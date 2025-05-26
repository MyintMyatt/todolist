import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';

Future<Duration?> pickReminderTime(BuildContext context) async {
  Duration? reminder = await showDurationPicker(
    context: context,
    initialTime: Duration(minutes: 5),
    lowerBound: Duration(seconds: 0),
    upperBound: Duration(minutes: 10)
  );
  print(reminder);
  return reminder;
}