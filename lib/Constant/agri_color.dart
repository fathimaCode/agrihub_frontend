import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AgriColors{
  static const Color primaryColor = Color(0xFF35A312);
  static const Color redColor = Color(0xFFFF1B00);
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static double screenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static double screenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
}