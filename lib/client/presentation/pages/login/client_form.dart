import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_ihma/core/validators.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/formatters.dart';
import '../../../../core/resources/datastate.dart';
import '../../../../core/utils/phone_input_utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/decription_text.dart';
import '../../../../di/di.dart';
import '../../../../main.dart';
import '../../../domain/entities/login_request_entity/login_request_entity.dart';
import '../../../domain/entities/type/type_entity.dart';
import '../../../domain/repositories/account_repository.dart';

class ClientRegisterForm extends StatefulWidget {
  final List<TypeEntity> documentTypes;

  const ClientRegisterForm({super.key, required this.documentTypes});

  @override
  State<ClientRegisterForm> createState() => _ClientLoginFormState();
}

class _ClientLoginFormState extends State<ClientRegisterForm> {
  bool _sentSms = false;
  bool _isResendActive = false;
  final ValueNotifier<int> _remainingTime = ValueNotifier<int>(10);
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  Timer? _timer;
  final FocusNode _phoneFocusNode = FocusNode();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _docSeriaController = TextEditingController();
  final TextEditingController _docNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  int? _selectedDocType;

  final accountRepository = sl<AccountRepository>();



  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _remainingTime.value = 10;
    _isResendActive = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--;
      } else {
        _isResendActive = true;
        setState(() {});
        timer.cancel();
      }
    });
  }

  void _handleSendSms() async {
    if (_formKey.currentState!.validate()) {
      _isLoading.value = true;
      final result = await accountRepository.askUserRegister(LoginRequestEntity(
        seria: _docSeriaController.text,
        number: _docNumberController.text,
        dateOfBirth: _birthDateController.text,
        documentTypeId: _selectedDocType,
        pinfl: "",
        phoneNumber: getFormattedPhone(_phoneController.text),
        verificationCode: "",
        email: "",
        password: "",
        addAsTrustedDevice: false,
        confirmPassword: "",
      ));

      if (result is DataSuccess && result.data == true) {
        setState(() {
          _sentSms = true;
        });
        _startTimer();
      }

      _isLoading.value = false;
    }
  }

  String _getFormattedTime() {
    return '${(_remainingTime.value ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime.value % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.bgDark : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.borderGray, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'register'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),

            descriptionText(text: "document_type".tr(), required: true),
            DropdownButtonFormField<int>(
              validator: Validators.validateDocumentType,
              isExpanded: true,
              value: _selectedDocType,
              dropdownColor: Theme.of(context).brightness == Brightness.dark ? Color(0xff1A1C28) : Colors.white,
              elevation: 20,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              hint: Text(
                'select_document_type'.tr(),
                style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal),
              ),
              items: widget.documentTypes.map((type) {
                return DropdownMenuItem(
                  value: type.value,
                  child: Text(type.text ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDocType = value!;
                });
              },
            ),
            const SizedBox(height: 10),

            // Document Series and Number Row
            Row(
              children: [
                // Document Series
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      descriptionText(text: "doc_seria".tr(), required: true),
                      TextFormField(
                        controller: _docSeriaController,
                        validator: Validators.validateDocSeria,
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'AA',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),

                        //reduce height size
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
                          LengthLimitingTextInputFormatter(2),
                          UpperCaseTextFormatter(),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Document Number
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      descriptionText(text: "doc_number".tr(), required: true),
                      TextFormField(
                        controller: _docNumberController,
                        validator: Validators.validateDocNumber,
                        keyboardType: TextInputType.datetime,

                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: '1234567',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(7),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Birth Date
            descriptionText(text: "birth_date".tr(), required: true),
            TextFormField(
              controller: _birthDateController,
              validator: ,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              },
              decoration: InputDecoration(
                hintText: 'KK.OO.YYYY',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_today,
                    color: AppColors.greenColor,
                  ),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      keyboardType: TextInputType.datetime,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      _birthDateController.text =
                          "${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}";
                    }
                  },
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              inputFormatters: [
                DateTextFormatter(),
              ],
            ),
            const SizedBox(height: 10),


            // Phone Number
            descriptionText(text: "phone".tr(), required: true),
            TextFormField(
              controller: _phoneController,
              validator: _validatePhone,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
              focusNode: _phoneFocusNode,
              decoration: InputDecoration(
                prefixStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: const Text('   +998-', style: TextStyle(fontSize: 16)),
                isDense: true,
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 24),
                hintText: '__-___-__-__',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(9),
                PhoneNumberFormatter(),
              ],
            ),
            const SizedBox(height: 30),

            if (_sentSms) ...[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    // SMS Code Input
                    SizedBox(
                      width: 270,
                      child: Center(
                        child: PinCodeTextField(
                          appContext: navigatorKey.currentContext!,
                          length: 6,
                          controller: _smsController,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          autoFocus: true,
                          cursorColor: AppColors.blueColor,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(6),
                            borderWidth: 0.5,
                            activeBorderWidth: 0.5,
                            inactiveBorderWidth: 0.5,
                            selectedBorderWidth: 1,
                            fieldHeight: 40,
                            fieldWidth: 35,
                            activeFillColor:
                                Theme.of(context).brightness == Brightness.dark ? AppColors.bgDark : Colors.white,
                            inactiveFillColor: AppColors.gray.withValues(alpha: 0.1),
                            selectedFillColor: AppColors.gray.withValues(alpha: 0.1),
                            activeColor: AppColors.greenColor,
                            inactiveColor: Colors.grey.withValues(alpha: 0.3),
                            selectedColor: AppColors.blueColor,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          onChanged: (value) {
                            // Optional: Add validation or auto-submit logic
                          },
                          beforeTextPaste: (text) {
                            return true; // Allow paste
                          },
                        ),
                      ),
                    ),
                    // Timer and Resend
                    Column(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _isResendActive
                              ? GestureDetector(
                                  onTap: () {
                                    _startTimer();
                                    _smsController.clear();
                                    setState(() {});
                                    // TODO: Add resend logic
                                  },
                                  child: Text(
                                    'resend_code'.tr(),
                                    style: TextStyle(
                                      color: AppColors.greenColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : ValueListenableBuilder(
                                  valueListenable: _remainingTime,
                                  builder: (context, value, child) {
                                    return Text(
                                      _getFormattedTime(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.blueColor,
                                      ),
                                    );
                                  }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Verify Button
                    ValueListenableBuilder<bool>(
                        valueListenable: _isLoading,
                        builder: (context, value, child) {
                          return CustomButton(
                            label: 'register'.tr(),
                            isEnabled: !value,
                            isLoading: value,
                            onPressed: () {
                              print('Verify button pressed');

                              if (_smsController.text.length == 6) {
                                // TODO: Add verification logic
                              }
                            },
                          );
                        }),
                  ],
                ),
              ),
            ] else ...[
              const SizedBox(height: 12),
              ValueListenableBuilder<bool>(
                  valueListenable: _isLoading,
                  builder: (context, value, child) {
                    return CustomButton(
                      label: 'send_sms'.tr(),
                      onPressed: _handleSendSms,
                      isEnabled: !value,
                      isLoading: value,
                    );
                  }),
            ],

            const SizedBox(height: 8),
            // Login Link
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'already_have_account'.tr(),
                  style: TextStyle(color: AppColors.greenColor, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
