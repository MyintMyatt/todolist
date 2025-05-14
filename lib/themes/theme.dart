
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData{
   static const Color darkGreyClr = Color(0xFF121212);
   static final lightTheme = ThemeData(
       brightness: Brightness.light,
       primaryColor: Colors.grey.shade100,
       useMaterial3: true);

   static final darkTheme = ThemeData(
       brightness: Brightness.dark,
       primaryColor: darkGreyClr,
       useMaterial3: true);

   static const Color blackBgColor= Color(0xff171719);
   static const Color blackColor= Color(0xff232229);
   static const Color whiteBgColor= Color(0xffd3dbe4);
   static const Color whiteColor = Color(0xfffcfbfe);
   static const Color greenColor = Color(0xff40c2a3);
   static const Color orangeColor = Color(0xfffd543b);

   TextStyle get largeTitleStyle {
      return GoogleFonts.cabin(textStyle: TextStyle(color: AppThemeData.greenColor, fontSize: 30, fontWeight: FontWeight.bold));
   }
   TextStyle get normalTitleStyle {
      return GoogleFonts.pacifico(textStyle: TextStyle( fontSize: 20, fontWeight: FontWeight.bold));
   }

   TextStyle get buttonTextStyle {
      return GoogleFonts.cabin(textStyle: TextStyle(color: Get.isDarkMode ? blackBgColor : whiteBgColor, fontSize: 16, fontWeight: FontWeight.bold));
   }

   TextStyle get normalTextStyle {
      return GoogleFonts.cabin(textStyle: TextStyle(color: Get.isDarkMode ? whiteBgColor : Colors.grey, fontSize: 16, fontWeight: FontWeight.bold));
   }

}