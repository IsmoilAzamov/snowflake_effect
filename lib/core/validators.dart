

import 'package:easy_localization/easy_localization.dart';

abstract class Validators{

 static String? validateDocumentType(int? value) {
    if (value == null) {
      return 'required'.tr();
    }
    return null;
  }

  static String? validateDocSeria(String? value) {
    if (value == null || value.isEmpty) {
      return 'required'.tr();
    }
    if (value.length != 2) {
      return 'required'.tr();
    }
    if (!RegExp(r'^[A-Z]{2}$').hasMatch(value)) {
      return 'required'.tr();
    }
    return null;
  }

  static String? validateDocNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'required'.tr();
    }
    if (value.length != 7) {
      return 'required'.tr();
    }
    if (!RegExp(r'^\d{7}$').hasMatch(value)) {
      return 'required'.tr();
    }
    return null;
  }

  static String? validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'required'.tr();
    }

    // Check format DD.MM.YYYY
    if (!RegExp(r'^\d{2}\.\d{2}\.\d{4}$').hasMatch(value)) {
      return 'required'.tr();
    }

    try {
      final parts = value.split('.');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final date = DateTime(year, month, day);

      if (date.isAfter(DateTime.now())) {
        return 'required'.tr();
      }

      return null;
    } catch (e) {
      return 'birth_date_invalid'.tr();
    }
  }

  static String? validatePhone(String? value) {
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
}