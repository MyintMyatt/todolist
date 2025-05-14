import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/theme_service.dart';
import '../themes/theme.dart';

homeHeadingBar(){
  AppThemeData theme = AppThemeData();
  ThemeService themeService = ThemeService();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Column(
            children: [
              Text(
                'Hello, Orion',
                style: theme.largeTitleStyle,
              ),
              Text(DateFormat.yMMMMd().format(DateTime.now()),style: theme.normalTitleStyle,)
            ],
          )
        ],
      ),
      CircleAvatar(
        backgroundImage: AssetImage('images/avator.png'),
      )
    ],
  );
}