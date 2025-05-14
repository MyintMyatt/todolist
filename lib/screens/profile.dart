import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:todolists/screens/home.dart';
import 'package:todolists/services/theme_service.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _switchController = ValueNotifier<bool>(false);
  late ThemeService themeService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeService = ThemeService();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.to(() => HomeScreen());}, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: AdvancedSwitch(
          width: 70,
          controller: _switchController,
          activeColor: Colors.black,
          inactiveColor: Colors.blue,
          activeChild: const Text('Light', style: TextStyle(color: Colors.white)),
          inactiveChild: const Text('Dark', style: TextStyle(color: Colors.white)),
          thumb: ValueListenableBuilder(valueListenable: _switchController, builder: (context,value, _){
            return Icon(value ? Icons.circle : Icons.circle, color: Colors.white);
          }),
          onChanged: (value){
            themeService.switchThemeMode();
          },
        ),

      ),
    );
  }
}
