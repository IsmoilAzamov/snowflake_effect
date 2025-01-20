import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../main.dart';
import 'continue_button.dart';

class SuccessBottomSheet extends StatefulWidget {
  final String message;

  const SuccessBottomSheet({super.key, required this.message});

  @override
  State<SuccessBottomSheet> createState() => _SuccessBottomSheetState();
}

class _SuccessBottomSheetState extends State<SuccessBottomSheet> {
  bool isDark = prefs.getString("theme") != 'light';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color:isDark?AppColors.bgDark: AppColors.blueColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          border: Border(
              top: BorderSide(
                  color: Colors.white
              )
          )
      ),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 12,
            ),
            Image.asset(
              'assets/images/start_work.png',
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.width * 0.55,
            ),
        
        
        
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              child: Text(
                "Ajoooyib! E-learning profilingizga muvoffaqiyatli kirdingiz! “Davom etish” ga bosing va o’quv jarayonini boshlang",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
        
        
            continueButton(onPressed: (){
              Navigator.of(context).pop();
            },
                color: Color(0xFFEAF2FF),
                textColor: AppColors.bgDark
        
        
            )
          ],
        ),
      ),
    );
  }
}