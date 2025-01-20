

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../domain/repositories/account_repository.dart';

class ContractorRegisterForm extends StatefulWidget {
  const ContractorRegisterForm({super.key});

  @override
  State<ContractorRegisterForm> createState() => _ContractorState();
}

class _ContractorState extends State<ContractorRegisterForm> {
  final _pinflController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _contractorFormKey = GlobalKey<FormState>();
  bool _sentSms = false;
  bool _isResendActive = false;
  Timer? _timer;
  final ValueNotifier<int> _remainingTime = ValueNotifier<int>(10);
  final _isLoading = ValueNotifier<bool>(false);
  final _smsController = TextEditingController();

  final accountRepository = sl<AccountRepository>();

  String? _validatePinfl(String? value) {
    if (value == null || value.isEmpty || value.length != 14) {
      return 'required'.tr();
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'required'.tr();
    }

    // Remove formatting characters
    final cleanPhone = value.replaceAll(RegExp(r'\D'), '');

    if (cleanPhone.length != 9) {
      return 'required'.tr();
    }

    return null;
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
    if (_contractorFormKey.currentState!.validate()) {
      _isLoading.value = true;
      final result = await accountRepository.askUserRegister(LoginRequestEntity(
        seria: "",
        number: "",
        dateOfBirth: _birthDateController.text,
        documentTypeId: 0,
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
          key: _contractorFormKey,
          child: Column(
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

              descriptionText(text: "pnfl".tr(), required: true),
              TextFormField(
                  controller: _pinflController,
                  validator: _validatePinfl,
                  textInputAction: TextInputAction.next,
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    counterText: "",
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    hintText: 'XXXXXXXXXXXXXXXX',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(14),
                  ]),
              descriptionText(text: "phone".tr(), required: true),
              TextFormField(
                controller: _phoneController,
                validator: _validatePhone,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
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
        ));
  }
}