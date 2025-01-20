
import 'package:flutter/material.dart';

import '../../main.dart';

String  getLogo(){
  try{
    bool isDark = prefs.getString("theme") != 'light';
    if(isDark){
      // print('dark');
      return 'assets/images/elrn_logo.png';
    } else{
      // print('light');
      return 'assets/images/elrn_logo_blue.png';
    }
  }  catch (e){
    // print(e);
    return 'assets/images/elrn_logo.png';
  }
}
