

import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

String getFormattedPhone(String phone) {
  //remove all additional characters
  String digitsOnly = phone.replaceAll(RegExp(r'[^0-9]'), '');
  //format the phone number
  return '+998$digitsOnly';
}
