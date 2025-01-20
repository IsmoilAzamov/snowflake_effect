import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants/app_colors.dart';
import 'continue_button.dart';

Widget noItemWidget({required Function() onPressed, String? text, String? buttonText}) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const SizedBox(),
      Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32.0),
            constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Image.asset(
              'assets/images/no_item.png',

              width: double.infinity,
              color: Theme.of(navigatorKey.currentContext!).brightness==Brightness.dark? AppColors.bgDark:AppColors.blueColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            text ?? "no_item".tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ],
      ),

      const SizedBox(),
      continueButton(
        onPressed: () {
          onPressed();},
        title: buttonText ?? "back".tr(),
      )
    ]),
  );
}