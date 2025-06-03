import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolists/screens/splash.dart';
import 'package:todolists/services/db_service.dart';
import 'package:todolists/services/theme_service.dart';
import 'package:todolists/themes/theme.dart';
import 'package:workmanager/workmanager.dart';

//for work manager
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData)async {
    if(taskName == 'insertRepeatTasks') {
      await DBService().insertTodayRepeatTasks();
    }
    return Future.value(true);
  });

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager().registerPeriodicTask('uniqueName', taskName)
  runApp(ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: ThemeService().thememode,
      home: Splash(),
    );
  }
}
