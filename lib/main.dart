import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolists/screens/splash.dart';
import 'package:todolists/services/db_service.dart';
import 'package:todolists/services/theme_service.dart';
import 'package:todolists/themes/theme.dart';
import 'package:timezone/data/latest_all.dart' as tl;
import 'package:timezone/timezone.dart' as tz;
// import 'package:workmanager/workmanager.dart';

//for work manager
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) async {
//     if (taskName == 'insertRepeatTasks') {
//       await DBService().insertTodayRepeatTasks();
//     }
//     return Future.value(true);
//   });
// }

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tl.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Rangoon'));

  const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/tododo');
  const InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // await GetStorage.init();
  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  // await Workmanager().registerPeriodicTask(
  //     'repeatTaskInserter', 'insertRepeatTasks',
  //     frequency: Duration(minutes: 5),
  //     initialDelay: Duration(seconds: 30),
  //     constraints: Constraints(
  //         networkType: NetworkType.not_required, requiresCharging: false));
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
