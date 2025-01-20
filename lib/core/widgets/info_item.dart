import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../main.dart';

Widget infoItem({required String title, required String? value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 12,),
      Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
      const SizedBox(height: 4,),
      Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(navigatorKey.currentState!.context).primaryColorDark,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(
                color: AppColors.blueColor,
              )
          ),
          child: Text(value??"-", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),)),
    ],
  );
}

