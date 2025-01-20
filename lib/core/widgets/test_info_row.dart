

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

Widget testInfoRow({required String title, required String iconName, Color? circleColor}) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor ?? AppColors.middleBlue,
        ),
        child: Image.asset(
          "assets/icons/$iconName",
          width: 24,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}


Widget navigationRow({required String title, required String iconName, Color? circleColor,  VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor ?? AppColors.middleBlue,
            ),
            child: Image.asset(
              "assets/icons/$iconName",
              width: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Icon(CupertinoIcons.chevron_right, color: Colors.white, size: 20,),
        ],
      ),
    ),
  );
}
