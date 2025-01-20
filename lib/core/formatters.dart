



import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    if (digits.isNotEmpty) {
      buffer.write(digits.substring(0, digits.length.clamp(0, 2)));
    }
    if (digits.length > 2) {
      buffer.write('-${digits.substring(2, digits.length.clamp(2, 5))}');
    }
    if (digits.length > 5) {
      buffer.write('-${digits.substring(5, digits.length.clamp(5, 7))}');
    }
    if (digits.length > 7) {
      buffer.write('-${digits.substring(7, digits.length.clamp(7, 9))}');
    }

    final string = buffer.toString();
    return TextEditingValue(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}



class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    if (text.length > 10) {
      return oldValue;
    }

    var newText = text.replaceAll(RegExp(r'\D'), '');

    if (newText.length > 8) {
      newText = newText.substring(0, 8);
    }

    final result = StringBuffer();

    for (var i = 0; i < newText.length; i++) {
      if (i == 2 || i == 4) {
        result.write('.');
      }
      result.write(newText[i]);
    }

    return TextEditingValue(
      text: result.toString(),
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}


