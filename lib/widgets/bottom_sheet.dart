import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolists/services/theme_service.dart';
import 'package:todolists/themes/theme.dart';
import 'package:todolists/widgets/datepicker.dart';
import 'package:todolists/widgets/reminder.dart';
import 'package:todolists/widgets/timePicker.dart';
import 'package:todolists/widgets/time_small_widgets.dart';

bottomSheet(
    {required BuildContext context,
    required AppThemeData theme,
    required ThemeService themeService,
    required Function(DateTime) selectedDate,
    required Function(String) selectedStartTime,
    required Function(String) selectedEndTime}) {
  Get.bottomSheet(
      elevation: 20,
      backgroundColor: Get.isDarkMode
          ? AppThemeData.blackBgColor
          : AppThemeData.whiteBgColor,
      SizedBox(
        width: double.infinity,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                      color: AppThemeData.greenColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Text(
                'Add Task',
                style: theme.subTitleStyle,
              ),
              TextFormField(
                maxLines: 3,
                cursorColor: AppThemeData.greenColor,
                decoration: InputDecoration(
                    hintText: 'write down task',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                    filled: true,
                    fillColor: Get.isDarkMode
                        ? AppThemeData.blackColor
                        : AppThemeData.whiteColor,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10))),
              ),
              Column(
                spacing: 10,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      timeSmallWidget(
                          fun: () async {
                            DateTime? pickedDate =
                                await datePicker(context: context);
                            if (pickedDate != null) {
                              selectedDate(pickedDate);
                            }
                          },
                          icon: Icons.calendar_month_rounded,
                          textWidget: Text(
                            '20',
                            style: theme.smallTextStyle,
                          )),
                      timeSmallWidget(
                          fun: () async {
                            TimeOfDay? startTime = await timePicker(context);
                            if(startTime != null){
                              selectedStartTime(startTime!.format(context));
                            }
                          },
                          icon: Icons.timer,
                          width: 98,
                          textWidget: Text(
                            'Start Time',
                            style: theme.smallTextStyle,
                          )),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      timeSmallWidget(
                          fun: () async{
                            TimeOfDay? endTime = await timePicker(context);
                            if(endTime != null){
                              selectedEndTime(endTime!.format(context));
                            }
                          },
                          icon: Icons.timer,
                          width: 98,
                          textWidget: Text(
                            'End Time',
                            style: theme.smallTextStyle,
                          )),
                      timeSmallWidget(
                          fun: () {
                            pickReminderTime(context);
                          },
                          icon: Icons.repeat,
                          textWidget: Text(
                            '20',
                            style: theme.smallTextStyle,
                          )),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ));
}
