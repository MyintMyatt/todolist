import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolists/models/AppData.dart';
import 'package:todolists/models/category.dart';
import 'package:todolists/services/db_service.dart';
import 'package:todolists/services/theme_service.dart';
import 'package:todolists/themes/theme.dart';
import 'package:todolists/widgets/datepicker.dart';
import 'package:todolists/widgets/drop_down.dart';
import 'package:todolists/widgets/reminder.dart';
import 'package:todolists/widgets/showDialog.dart';
import 'package:todolists/widgets/timePicker.dart';
import 'package:todolists/widgets/time_small_widgets.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final AppThemeData theme;
  final ThemeService themeService;

  const AddTaskBottomSheet({
    super.key,
    required this.theme,
    required this.themeService,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  AnimationStyle? _dropDownAnimatingStyle;

  String _selectedDate = DateFormat('dd').format(DateTime.now());
  String?
      _selectedStartTime; // = TimeOfDay(hour: now.hour, minute: now.minute).format(context);
  String? _selectedEndTime;
  String? _selectedCategory;
  String? _selectedPriority;
  String? _selectedRepeat;
  int? _repeatInterval;
  String? _repeatUnit;// to show ui
  String? _selectedReminder; // to show ui
  int? _selectedReminderMinutes; // to store in db

  List<String> newCategoryList = [];
  late DBService dbService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dropDownAnimatingStyle = AnimationStyle(
      curve: Easing.emphasizedDecelerate,
      duration: const Duration(seconds: 2),
    );
    dbService = DBService();
    loadCategoryFromDB();

  }

  loadCategoryFromDB() async{
    List<String> list = await dbService.getCategories();
    setState(() {
      newCategoryList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = AppData().categoryDropDown + newCategoryList;
    categoryList.add('+ New');
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 7),
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
              style: widget.theme.subTitleStyle,
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
              children: [
                Container(
                  color: Colors.transparent,
                  height: 60,
                  alignment: Alignment.topCenter,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding:
                        EdgeInsets.only(top: 5, bottom: 20, left: 5, right: 5),
                    children: [
                      timeSmallWidget(
                          fun: () async {
                            DateTime? pickedDate =
                                await datePicker(context: context);
                            if (pickedDate != null) {
                              setState(() {
                                _selectedDate =
                                    DateFormat('dd').format(pickedDate);
                              });
                            }
                          },
                          icon: Icons.calendar_month_rounded,
                          textWidget: Text(
                            _selectedDate,
                            style: widget.theme.smallTextStyle,
                          )),
                      timeSmallWidgetDropdown(
                        items: categoryList,
                        onItemSelected: (value) {
                          setState(() {
                            _selectedCategory = value;// for existing category
                          });
                          if(_selectedCategory == '+ New'){
                            showDialogForCustom(
                                context: context,
                                dbService: dbService,
                                theme: widget.theme,
                                newCustomValue: (value) async{
                                 int categoryId =  await dbService.addNewCategory(Category(categoryName: value));
                                 print('Successfully registered Category id => $categoryId');
                                  await loadCategoryFromDB(); // reload after adding
                                  _selectedCategory = value;// for new category
                                },
                                animationSytle: _dropDownAnimatingStyle!,isRequiredIcon: false);
                            loadCategoryFromDB(); // for sync new category in dropdown
                          }
                          // You can store the selected value in a variable if needed
                        },
                        icon: Icons.category,
                        animationSytle: _dropDownAnimatingStyle!,
                        width: 90,
                        textWidget: Flexible(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            _selectedCategory ?? 'Category',
                            style: widget.theme.smallTextStyle,
                          ),
                        ),
                      ),
                      timeSmallWidget(
                          fun: () async {
                            TimeOfDay? startTime = await timePicker(context);
                            if (startTime != null) {
                              setState(() {
                                _selectedStartTime = startTime.format(context);
                              });
                            }
                          },
                          icon: Icons.access_alarm,
                          width: 90,
                          textWidget: Text(
                            _selectedStartTime ?? 'start time',
                            style: widget.theme.smallTextStyle,
                          )),
                      timeSmallWidget(
                          fun: () async {
                            TimeOfDay? endTime = await timePicker(context);
                            if (endTime != null) {
                              setState(() {
                                _selectedEndTime = endTime.format(context);
                              });
                            }
                          },
                          icon: Icons.access_alarm,
                          width: 90,
                          textWidget: Text(
                            _selectedEndTime ?? 'end time',
                            style: widget.theme.smallTextStyle,
                          )),
                      timeSmallWidgetDropdown(
                        items: AppData.repeatDropDown,
                        onItemSelected: (value) {
                          setState(() {
                            _selectedRepeat = value;
                          });
                          if (_selectedRepeat == 'Custom') {
                            showDialogForCustom(
                                context: context,
                                dbService:  dbService,
                                theme: widget.theme,
                                newCustomValue:  (value) {
                                  _repeatInterval = int.parse(value);// for new repeat value
                                },
                                repeatType: (value){
                                  _repeatUnit = value;
                                },
                                animationSytle: _dropDownAnimatingStyle!, isRequiredIcon: true);
                          }
                          // You can store the selected value in a variable if needed
                        },
                        icon: Icons.repeat,
                        animationSytle: _dropDownAnimatingStyle!,
                        width: 90,
                        textWidget: Flexible(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            _selectedRepeat != 'Custom' ? _selectedRepeat??'Repeat' : '$_repeatInterval $_repeatUnit',
                            style: widget.theme.smallTextStyle,
                          ),
                        ),
                      ),
                      timeSmallWidget(
                          fun: ()async {
                           Duration? selectedReminder = await pickReminderTime(context);
                           String reminder = '${selectedReminder!.inHours} and ${selectedReminder.inMinutes} and ${selectedReminder.inDays}';
                           print(reminder);
                           int reminderMinutes = selectedReminder.inMinutes;
                           int reminderHour = reminderMinutes ~/ 60;
                           int reminderMin = reminderMinutes % 60;
                           setState(() {
                             _selectedReminder = reminderHour != 0 ? '$reminderHour h : $reminderMin m' : '$reminderMin m';
                           });
                          },
                          icon: Icons.timer,
                          width: 90,
                          textWidget: Text(
                            _selectedReminder??'Reminder',
                            style: widget.theme.smallTextStyle,
                          )),
                      timeSmallWidgetDropdown(
                        items: AppData.priorityDropDown,
                        onItemSelected: (value) {
                          setState(() {
                            _selectedPriority = value;
                          });
                          // You can store the selected value in a variable if needed
                        },
                        icon: Icons.low_priority_rounded,
                        animationSytle: _dropDownAnimatingStyle!,
                        width: 90,
                        textWidget: Flexible(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            _selectedPriority ?? 'Priority',
                            style: widget.theme.smallTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(20),
                        fixedSize: WidgetStatePropertyAll(Size(130, 47)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            WidgetStatePropertyAll(AppThemeData.orangeColor)),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? AppThemeData.blackBgColor
                              : AppThemeData.whiteBgColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
