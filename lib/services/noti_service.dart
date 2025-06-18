import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  static Future<void> scheduleDailyNoti()
}
