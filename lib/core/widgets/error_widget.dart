import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/get_logo.dart';
import '../../../../main.dart';

Widget errorWidget({required String text, required VoidCallback onPressed, String? imageUrl, String? buttonText}) {
  return Container(
    padding: const EdgeInsets.all(16),
    color: Colors.transparent,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl??getLogo(),
            width: MediaQuery.of(navigatorKey.currentContext!).size.width * 0.45,
          ),
          const SizedBox(height: 24),
          Text(text,textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onPressed,
            child:  Text(buttonText??'retry'.tr(),),
          ),
        ],
      ),
    ),
  );
}