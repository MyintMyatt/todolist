import 'package:flutter/material.dart';

Future<TimeOfDay?> timePicker(BuildContext context) async{
  return await showTimePicker(context: context, initialTime: TimeOfDay(hour: 0, minute: 0));
}