import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolists/services/theme_service.dart';
import 'package:todolists/themes/theme.dart';
import 'package:todolists/widgets/bottom_nav_bar.dart';
import 'package:todolists/widgets/bottom_sheet.dart';
import 'package:todolists/widgets/home_heading_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppThemeData theme = AppThemeData();

  ThemeService themeService = ThemeService();

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeService.loadThemeMode
          ? AppThemeData.blackBgColor
          : AppThemeData.whiteBgColor,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 70),
        child: Column(
          children: [homeHeadingBar()],
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppThemeData.greenColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Get.bottomSheet(
            elevation: 20,
            backgroundColor: Get.isDarkMode
                ? AppThemeData.blackBgColor
                : AppThemeData.whiteBgColor,
              AddTaskBottomSheet(
                  theme: theme,
                  themeService: themeService,
                  )
          );

        },
        child: Icon(
          CupertinoIcons.add,
          color: AppThemeData.whiteColor,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
