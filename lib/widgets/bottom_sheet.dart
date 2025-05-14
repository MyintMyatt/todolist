import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todolists/services/theme_service.dart';
import 'package:todolists/themes/theme.dart';

bottomSheet(AppThemeData theme, ThemeService themeService) {
  Get.bottomSheet(
    elevation: 10,
      backgroundColor: AppThemeData.blackBgColor,
      SizedBox(
    width: double.infinity,
    height: 300,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
                color: AppThemeData.greenColor,
              borderRadius: BorderRadius.circular(20)
            ),
          )
        ],
      ),
    ),
  ));
}
