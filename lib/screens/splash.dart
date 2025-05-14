import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todolists/screens/home.dart';
import 'package:todolists/themes/theme.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AppThemeData appThemeData = AppThemeData();

  @override
  Widget build(BuildContext context) {
    Size screen_size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screen_size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/mantolist.png'),
                          fit: BoxFit.cover)),
                ),
                Text('Smart Task \nManagement', style: appThemeData.largeTitleStyle,),
                SizedBox(height: 15,),
                Text('This smart tool is designed to help you better manage your tasks.', style: appThemeData.normalTextStyle,),
                Text('Stay organized, stay productive.', style: appThemeData.normalTextStyle,),
                Text('Plan your day, one task at a time.', style: appThemeData.normalTextStyle,),
              ],
            ),
            // Center(
            //   child: SvgPicture.asset(
            //       alignment: Alignment.centerRight,
            //       height: 400,
            //       width: screen_size.width,
            //       fit: BoxFit.cover,
            //       'images/womanTodoListGreen.svg'),
            // ),
           // Column(
           //   mainAxisAlignment: MainAxisAlignment.start,
           //   crossAxisAlignment: CrossAxisAlignment.start,
           //   children: [
           //     Text('Smart Task Management')
           //   ],
           // ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => HomeScreen());
                },
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(20),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
                  backgroundColor:
                      WidgetStatePropertyAll(AppThemeData.greenColor),
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                ),
                child: Text(
                  'Get Started',
                  style: appThemeData.buttonTextStyle,
                ))
          ],
        ),
      ),
    );
  }
}
