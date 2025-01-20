import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

String getLangCode() {
  try {
    BuildContext context = navigatorKey.currentContext!;
    String langCode = "";
    // print(context.locale);
    // print(context.locale.toString());
    switch (context.locale.toString()) {
      case "uz_UZ":
        langCode = "uz-latn";

        break;
      case "ru_RU":
        langCode = "ru";
        break;
      case "kk_KZ":
        langCode = "qr";
        break;
      default:
        langCode = "uz-latn";
        break;
    }
    print(langCode);
    return langCode;
  } on Error {
    // print(e);
    // print(e.stackTrace);
    return "uz";
  }
}
