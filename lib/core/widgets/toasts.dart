import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';

//success toast


//error toast

void showErrorToast(String message) {
  toastification.dismissAll();

  toastification.show(
    title: Text(
      message,
      textAlign: TextAlign.center,
      maxLines: 3,
      style: const TextStyle(color: Colors.white),
    ),
    showProgressBar: false,
    showIcon: true,

    backgroundColor: Color(0xffAE0000),
    primaryColor: Color(0xffAE0000),
    icon: const Icon(
      Icons.error_outline,
      color: Colors.white70,
    ),
    closeButtonShowType: CloseButtonShowType.none,
    alignment: Alignment.topCenter,
    applyBlurEffect: true,

    pauseOnHover: true,
    borderSide: BorderSide.none,
    margin: const EdgeInsets.all(12),
    style: ToastificationStyle.flat,
    type: ToastificationType.warning,
    autoCloseDuration: const Duration(seconds: 3),
  );
}

void showSuccessToast(String message) {

  toastification.show(
    title: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
    showProgressBar: false,
    showIcon: true,

    backgroundColor: AppColors.greenColor,
    primaryColor: AppColors.greenColor,
    icon: const Icon(
      Icons.check_circle_outline,
      color: Colors.white70,
    ),
    closeButtonShowType: CloseButtonShowType.none,
    alignment: Alignment.topCenter,
    applyBlurEffect: true,
    pauseOnHover: true,
    borderSide: BorderSide.none,
    margin: const EdgeInsets.all(12),
    style: ToastificationStyle.flat,
    type: ToastificationType.success,
    autoCloseDuration: const Duration(seconds: 3),
  );
}

void showSimpleToast(String message) {
  toastification.dismissAll();
  toastification.show(
    title: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
    showProgressBar: false,
    showIcon: true,
    backgroundColor: const Color(0xff333333),
    primaryColor: const Color(0xff333333),
    icon: const Icon(
      Icons.check_circle_outline,
      color: Colors.white70,
    ),
    closeButtonShowType: CloseButtonShowType.none,
    alignment: Alignment.topCenter,
    applyBlurEffect: true,
    pauseOnHover: true,
    borderSide: BorderSide.none,
    margin: const EdgeInsets.all(12),
    style: ToastificationStyle.flat,
    type: ToastificationType.info,
    autoCloseDuration: const Duration(seconds: 3),

  );
}