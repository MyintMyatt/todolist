import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todolists/controller/bottom_nav_controller.dart';
import 'package:todolists/screens/profile.dart';
import 'package:todolists/themes/theme.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: Get.isDarkMode ? AppThemeData.blackColor: AppThemeData.whiteColor,
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Padding(
        padding: const EdgeInsets.only(right: 60),
        child: Row(
          children: [
            navIcons((){}, FontAwesomeIcons.house),
            navIcons((){}, FontAwesomeIcons.solidCalendar),
            navIcons((){}, FontAwesomeIcons.clock),
            navIcons((){
              Get.to(() => MyProfile());
            }, FontAwesomeIcons.solidUser),
          ],
        ),
      ),
    );
  }

  navIcons(Function() fun, IconData icon) {
    return Expanded(
        child: IconButton(
            onPressed: fun,
            icon: Icon(
              icon,
              color: AppThemeData.greenColor,
            )));
  }
}
