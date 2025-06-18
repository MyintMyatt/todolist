import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todolists/main.dart';
import 'package:todolists/models/task.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as t;

class NotificationService {
  static const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('channelId', 'To Do Channel',
      channelDescription: 'Used for To-Do notification',
      importance: Importance.max,
      priority: Priority.high
  );

  static const NotificationDetails notificationDetails =
  NotificationDetails(
      android: androidNotificationDetails
  );

  static Future<void> scheduleDailyNoti(
      {required int notiID, required Task task}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notiID, 'Daily Task', task.desc, _nextInstanceOfTime(1, 2, 0), notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute, int second) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
        second
    );

    if(scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
