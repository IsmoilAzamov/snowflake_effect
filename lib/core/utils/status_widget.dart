import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

Widget statusWidget(String? status, int? statusId) {
  return Container(
    decoration: BoxDecoration(
      color: getStatusColorWithOpacity(statusId),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: getStatusColor(statusId)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
    child: Text(
      status ?? '',
      style: TextStyle(color: getStatusColor(statusId), fontSize: 14, fontWeight: FontWeight.w600),
    ),
  );
}


Color getStatusColor(int? statusId) {
  switch (statusId) {
    case 7||16:
      return AppColors.greenColor;
    case 2:
      return AppColors.yellowColor;
    case 3||10||8:
      return AppColors.redColor;
    case 4:
      return AppColors.yellowColor;
    default:
      return AppColors.blueColor;
  }
}

Color getStatusColorWithOpacity(int? statusId) {
  switch (statusId) {
    case 7||16:
      return AppColors.greenColor.withOpacity(0.2);
    case 2:
      return AppColors.yellowColor.withOpacity(0.2);
    case 3||10||8:
      return AppColors.redColor.withOpacity(0.2);
    case 4:
      return AppColors.yellowColor.withOpacity(0.2);
    default:
      return AppColors.blueColor.withOpacity(0.2);
  }
}