import 'package:flutter/material.dart';

import '../../main.dart';

extension CustomTexts on Text {
  Text getSumsFixed({String text = '', Color? color, double? fontSize, FontWeight? fontWeight}) {
    return Text(
      '${data.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} $text',
      style: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium
    );
  }

  Text capitalize() {
    return Text(data.toString().capitalize());
  }
}

String getSumsFixed({String text = '', Color? color, double? fontSize, FontWeight? fontWeight}) {
  return text.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
}

extension CustomStrings on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension CapitalizeExtension on String {
  String toCapitalized() {
    return split(' ')
        .map((word) => word.isNotEmpty
        ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
        : word)
        .join(' ');
  }
}
