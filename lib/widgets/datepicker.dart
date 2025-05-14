import 'package:flutter/material.dart';
import 'package:todolists/themes/theme.dart';

Future<DateTime?> datePicker({required BuildContext context}) async {
  return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      barrierColor: AppThemeData.greenColor.withValues(alpha: 0.2),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));
}
