

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

Widget customTile({required String title, String? iconUrl, required VoidCallback onTap,  Color? iconBgColor}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:iconBgColor ?? AppColors.middleBlue,
          ),
          child: Image.asset(
            iconUrl??'',
            width: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        const Icon(CupertinoIcons.chevron_right, color: Colors.white,),
      ],
    ),
  );
}