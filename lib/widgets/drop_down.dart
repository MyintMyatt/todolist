import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show Colors, PopupMenuButton, PopupMenuItem, Widget;
import 'package:get/get.dart';
import 'package:todolists/themes/theme.dart';

Widget timeSmallWidgetDropdown({
  required List<String> items,
  required Function(String) onItemSelected,
  required IconData icon,
  required AnimationStyle animationSytle,
  double? width,
  Widget? textWidget,
  bool? isRemainRequiredFields = false
}) {
  return PopupMenuButton<String>(
    popUpAnimationStyle: animationSytle,
    onSelected: onItemSelected,
    itemBuilder: (context) {
      return items
          .map((item) => PopupMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList();
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 3),
      width: width ?? 55,
      height: 36,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppThemeData.greenColor,
          AppThemeData.gradientGreenColor,
        ]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Get.isDarkMode
                ? isRemainRequiredFields! ? Colors.red : AppThemeData.blackBgColor
                : isRemainRequiredFields! ? Colors.red : AppThemeData.whiteBgColor,
          ),
          if (textWidget != null) SizedBox(width: 5),
          textWidget ?? Container(),
        ],
      ),
    ),
  );
}
