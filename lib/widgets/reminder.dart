import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';

Future<Duration?> pickReminderTime(BuildContext context) async {
  Duration? reminder = await showDurationPicker(
    context: context,
    initialTime: Duration(minutes: 10),
  );
  return reminder;
}