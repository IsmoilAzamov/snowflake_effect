import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAppDialog(BuildContext context, {required String text, required Future Function() onSubmitted}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text('attention'.tr()),
        ),
        content: Text(text),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('no'.tr(), style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 16.0)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('yes'.tr(), style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 16.0)),
            onPressed: () async {
              Navigator.of(context).pop();
              await onSubmitted();
            },
          ),
        ],
      );
    },
  );
}