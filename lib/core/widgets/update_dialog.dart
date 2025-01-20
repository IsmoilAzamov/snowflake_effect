// //create update dialog abstract class
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../main.dart';
// import '../constants/app_colors.dart';
//
// void checkNewVersion(BuildContext context, {required String currentVersion}) async {
//   final String collectionName = Platform.isAndroid ? 'android' : 'ios';
//   final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection(collectionName).doc('document').get();
//   bool forceUpdate = doc.get('force') ?? false;
//   String version = doc.get('version') ?? currentVersion;
//   String text = doc.get('text') ?? '';
//   bool hasUpdate = await isNewerVersion(currentVersion, version);
//   // print("+++++++++++++++++++");
//   // print(forceUpdate);
//   // print(text);
//   // print(version);
//   // print("+++++++++++++++++++");
//   if (hasUpdate) {
//     // print("+++++++++++++++++++");
//     // print(forceUpdate);
//     // print(text);
//     // print(version);
//     // print("+++++++++++++++++++");
//     if (context.mounted) {
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return UpdateDialog(
//               force: forceUpdate,
//               description: text,
//               version: version,
//               androidLink: 'https://play.google.com/store/apps/',
//               iosLink: 'https://play.google.com/store/apps/details?id=uz.kontrakt.eduuz',
//             );
//           });
//     }
//     // newVersion.showUpdateDialog(
//     //   context: context,
//     //   versionStatus: status,
//     //   dialogText: 'New Version is available in the store (${status.storeVersion}), update now!',
//     //   dialogTitle: 'Update is Available!',
//     // );
//   }
// }
//
// Future<bool> isNewerVersion(String currentVersion, String version) async {
//   final List<String> currentVersionParts = currentVersion.split('.');
//   final List<String> versionParts = version.split('.');
//   int oldVersion = int.parse(currentVersionParts.join());
//   int newVersion = int.parse(versionParts.join());
//
//   if (newVersion > oldVersion) {
//     String dismissedTime = box.get('updateDismissedTime') ?? DateTime(2024, 1, 1).toString();
//     String currentTime = DateTime.now().toString();
//     if (dismissedTime.isNotEmpty) {
//       DateTime dismissedDateTime = DateTime.parse(dismissedTime);
//       DateTime currentDateTime = DateTime.parse(currentTime);
//       Duration difference = currentDateTime.difference(dismissedDateTime);
//       if (difference.inHours < 12) {
//         return false;
//       }
//     }
//     return true;
//   } else if (newVersion == oldVersion) {
//     return false;
//   }
//
//   return newVersion > oldVersion;
// }
//
// class UpdateDialog extends StatefulWidget {
//   final String version;
//   final String description;
//   final String androidLink;
//   final String iosLink;
//   final bool force;
//
//   const UpdateDialog({
//     super.key,
//     required this.version,
//     required this.description,
//     required this.androidLink,
//     required this.iosLink,
//     required this.force,
//   });
//
//   @override
//   State<UpdateDialog> createState() => _UpdateDialogState();
// }
//
// class _UpdateDialogState extends State<UpdateDialog> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     if (widget.force) {
//       SystemNavigator.pop();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return ScaleTransition(
//       scale: CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeOutBack,
//       ),
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         child: Container(
//           width: screenWidth * 0.85,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Theme.of(context).brightness == Brightness.dark ? AppColors.bgDark : Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Custom Illustration or Icon
//               SizedBox(
//                 height: 120,
//                 child: Center(
//                   child: Image.asset(
//                     Theme.of(context).brightness == Brightness.dark ? 'assets/images/elrn_logo.png' : 'assets/images/elrn_logo_blue.png', // Replace with your asset
//                     height: 100,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "${'version'.tr()}: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     widget.version,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               Text(
//                 widget.description,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               // Buttons
//               Row(
//                 children: [
//                   if (!widget.force)
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () {
//                           box.put('updateDismissedTime', DateTime.now().toString());
//                           Navigator.pop(context);
//                         },
//                         style: OutlinedButton.styleFrom(
//                           backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.middleBlue,
//                           side: BorderSide(
//                             color: Theme.of(context).primaryColor,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           "later".tr().toUpperCase(),
//                           style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? AppColors.bgDark : Colors.white, fontSize: 14),
//                         ),
//                       ),
//                     ),
//                   if (!widget.force) const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         final link = Platform.isAndroid ? widget.androidLink : widget.iosLink;
//                         if (link.isNotEmpty) await launchUrl(Uri.parse(link));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Theme.of(context).primaryColor,
//                         side: BorderSide(
//                           color: Theme.of(context).primaryColorLight,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text(
//                         "update".tr().toUpperCase(),
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.blueColor,
//                           fontSize: 14
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
