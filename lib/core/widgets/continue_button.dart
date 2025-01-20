import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../main.dart';

Widget continueButton({required VoidCallback onPressed, bool isLoading = false, String? title, Color? color, Color? textColor, double? elevation,  Color? bottomColor}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border(
          bottom: BorderSide(color: bottomColor ?? AppColors.darkBlue.withOpacity(0.8), width: 3),
        )),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(elevation ?? 2.0),
          backgroundColor: isLoading
              ? WidgetStateProperty.all(AppColors.borderGray)
              : color != null
                  ? WidgetStateProperty.all(color)
                  : (prefs.getString("theme") != 'light'? WidgetStateProperty.all(const Color(0xFFEAF2FF)) : WidgetStateProperty.all(AppColors.blueColor)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(
          title ?? 'continue'.tr(),
          style: TextStyle(
            color: textColor ?? (prefs.getString("theme") != 'light' ? AppColors.bgDark : Colors.white),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
