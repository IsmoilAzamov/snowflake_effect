import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, this.message});

  final String? message;

  void close(BuildContext context) {
    Navigator.of(context).pop();
  }

  void show(BuildContext context) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      barrierDismissible: false,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xffffffff),
      shadowColor: Colors.grey[500],
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.only(bottom: 400, left: 30, right: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[400],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30, width: 30, child: CupertinoActivityIndicator()),
            const SizedBox(width: 24),
            Text(message == null ? "${'loading'.tr()}..." : message!, style: const TextStyle(fontSize: 16, color: Color(0xff333333), fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
