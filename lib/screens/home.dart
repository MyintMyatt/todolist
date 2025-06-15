import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolists/models/task.dart';
import 'package:todolists/models/task_history.dart';
import 'package:todolists/services/db_service.dart';
import 'package:todolists/services/theme_service.dart';
import 'package:todolists/themes/theme.dart';
import 'package:todolists/widgets/bottom_nav_bar.dart';
import 'package:todolists/widgets/bottom_sheet.dart';
import 'package:todolists/widgets/home_heading_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppThemeData theme = AppThemeData();

  ThemeService themeService = ThemeService();

  DateTime? _selectedDate;

  List<TaskHistory> taskHistoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async{
      print('loading task.....');
      List<TaskHistory> list = await DBService().getAllTaskHistory();
      setState(() {
        taskHistoryList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeService.loadThemeMode
          ? AppThemeData.blackBgColor
          : AppThemeData.whiteBgColor,
      body:
           Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 70),
        child: Column(
          children: [homeHeadingBar(),
            taskHistoryList.length == 0 ? Text('No task'):
            Expanded(
              child: ListView.builder(
              itemCount: taskHistoryList.length,
                itemBuilder: (context, index){
                TaskHistory task = taskHistoryList[index];
                  return Card(
                    child: ListTile(
                      title: Text(task.desc),
                      subtitle: Row(
                        children: [
                          Text(DateFormat('yyyy-MM-dd').format(task.todayDate)),
                          SizedBox(width: 10,),
                          Text(task.repeatType),
                          SizedBox(width: 10,),
                          Text('${task.startTime} - ${task.endTime}')
                        ],
                      ),
                    ),
                  );

                }),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppThemeData.greenColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Get.bottomSheet(
            elevation: 20,
            backgroundColor: Get.isDarkMode
                ? AppThemeData.blackBgColor
                : AppThemeData.whiteBgColor,
              AddTaskBottomSheet(
                  theme: theme,
                  themeService: themeService,
                  )
          );

        },
        child: Icon(
          CupertinoIcons.add,
          color: AppThemeData.whiteColor,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
