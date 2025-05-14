import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolists/themes/theme.dart';

Widget timeSmallWidget(
    {required Function() fun,
    required IconData icon,
    double? width,
    Text? textWidget}) {
  return GestureDetector(
    onTap: fun,
    child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: width ?? 70,
        height: 36,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [ // your current green
              AppThemeData.greenColor, // your current green
              AppThemeData.gradientGreenColor, // your current green

            ]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 12,
                offset: Offset(0, 6),
              )
              // soft drop shadow
            ]),
        child: Row(
          spacing: 2,
          children: [
            Icon(
              icon,
              color: Get.isDarkMode
                  ? AppThemeData.blackBgColor
                  : AppThemeData.whiteBgColor,
            ),
            textWidget ?? Container()
          ],
        )),
  );
}
