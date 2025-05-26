import 'package:flutter/material.dart';
import 'package:todolists/themes/theme.dart';

Future<DateTime?> datePicker({required BuildContext context}) async {
  return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      barrierColor: AppThemeData.greenColor.withValues(alpha: 0.02),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));
}
// Row(
//   spacing: 5,
//   children: [
//     timeSmallWidget(
//         fun: () async {
//           DateTime? pickedDate =
//               await datePicker(context: context);
//           if (pickedDate != null) {
//             setState(() {
//               _selectedDate =
//                   DateFormat('dd').format(pickedDate);
//             });
//           }
//         },
//         icon: Icons.calendar_month_rounded,
//         textWidget: Text(
//           _selectedDate,
//           style: widget.theme.smallTextStyle,
//         )),
//     timeSmallWidget(
//         fun: () async {
//           TimeOfDay? startTime = await timePicker(context);
//           if (startTime != null) {
//             setState(() {
//               _selectedStartTime = startTime.format(context);
//             });
//           }
//         },
//         icon: Icons.access_alarm,
//         width: 90,
//         textWidget: Text(
//           _selectedStartTime ?? 'start time',
//           style: widget.theme.smallTextStyle,
//         )),
//     timeSmallWidget(
//         fun: () {},
//         icon: Icons.category,
//         width: 90,
//         textWidget: Text(
//           'category',
//           style: widget.theme.smallTextStyle,
//         ))
//   ],
// ),
// Row(
//   spacing: 5,
//   children: [
//     timeSmallWidget(
//         fun: () async {
//           TimeOfDay? endTime = await timePicker(context);
//           if (endTime != null) {
//             setState(() {
//               _selectedEndTime = endTime.format(context);
//             });
//           }
//         },
//         icon: Icons.access_alarm,
//         width: 90,
//         textWidget: Text(
//           _selectedEndTime ?? 'end time',
//           style: widget.theme.smallTextStyle,
//         )),
//     timeSmallWidget(
//         fun: () {
//           pickReminderTime(context);
//         },
//         icon: Icons.repeat,
//         textWidget: Text(
//           'D',
//           style: widget.theme.smallTextStyle,
//         )),
//     timeSmallWidget(
//         fun: () {
//           pickReminderTime(context);
//         },
//         icon: Icons.timer,
//         width: 90,
//         textWidget: Text(
//           'Reminder',
//           style: widget.theme.smallTextStyle,
//         )),
//   ],
// ),