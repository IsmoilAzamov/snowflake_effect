import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/formatters.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_switch.dart';
import '../../../../core/widgets/decription_text.dart';
import '../../../../core/widgets/toasts.dart';
import '../../../../di/di.dart';
import '../../../../main.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocProvider(
                create: (context) => themeBloc,
                child: FlutterSwitch(
                  width: 50.0,
                  height: 24.5,
                  toggleSize: 24.5,
                  value: Brightness.dark == Theme.of(context).brightness,
                  borderRadius: 30.0,
                  padding: 0.0,
                  activeToggleColor: AppColors.bgDark,
                  inactiveToggleColor: Color(0xFF2F363D),
                  activeSwitchBorder: Border.all(
                    color: AppColors.middleBlue,
                    width: 1.0,
                  ),
                  inactiveSwitchBorder: Border.all(
                    color: AppColors.lightGray,
                    width: 1.0,
                  ),
                  activeColor: AppColors.middleBlue,
                  inactiveColor: AppColors.lightGray,
                  activeIcon: Icon(
                    Icons.nightlight_round,
                    color: Color(0xFFFFDF5D),
                  ),
                  inactiveIcon: Icon(
                    Icons.wb_sunny,
                    color: Color(0xFFFFDF5D),
                  ),
                  onToggle: (val) {
                    var themeBloc = BlocProvider.of<ThemeBloc>(context);
                    //if bloc is disposed then create a new one
                    if (themeBloc.isClosed) {
                      themeBloc = sl<ThemeBloc>();
                    }

                    if (val) {
                      prefs.setString('theme', 'dark');
                      themeBloc.add(ToggleDark());
                    } else {
                      prefs.setString('theme', 'light');
                      themeBloc.add(ToggleLight());
                    }
                    // print("theme: ${themeBloc.state}");
                    homeBloc.add(0);
                    // setState(() {});
                  },
                ),
              ),
              LoginForm(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isPasswordVisible = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isReliable = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.bgDark : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.borderGray, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phone Number Field
          SizedBox(
            width: double.infinity,
            child: Text(
              'login_system'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 2),
          descriptionText(text: "phone".tr(), required: true),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixStyle: const TextStyle(color: Colors.grey, fontSize: 16),
              prefixIcon: Text('    +998-', style: TextStyle(fontSize: 16)),
              isDense: true,
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 24),
              hintText: '__-___-__-__',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
            onChanged: (value) {
              print(value);
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9),
              PhoneNumberFormatter(),
            ],
          ),
          const SizedBox(height: 6),

          // Password Field
          descriptionText(text: "password".tr(), required: true),
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: 'password'.tr(),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 20.0),
          // checkbox is reliable
          CustomSwitchRow(
            value: _isReliable,
            onChanged: (value) {
              setState(() {
                _isReliable = value;
              });
            },
            label: 'add_to_reliable_device'.tr(),
          ),

          const SizedBox(height: 20.0),

          CustomButton(label: 'login_system'.tr(), onPressed: () {}),
          const SizedBox(height: 8.0),

          const SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //register
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 120),
                    child: Text(
                      'register'.tr(),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: const TextStyle(color: AppColors.greenColor, fontSize: 14),
                    ),
                  ),
                ),
                // forgot password
                TextButton(
                  onPressed: () {
                    showSimpleToast("coming_soon".tr());
                  },
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 140),
                    child: Text(
                      'forgot_password'.tr(),
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      style: const TextStyle(color: AppColors.greenColor, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
