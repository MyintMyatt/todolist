import 'package:todolists/enum/task_status.dart';

class TaskHistory {
  int taskId;
  String desc;
  DateTime startDate;
  DateTime todayDate;
  String startTime;
  String endTime;
  String categoryName;
  String? reminder;
  String repeatType;
  int? repeatInterval;
  String? repeatTimeUnit; // day or week or month
  String priority;
  DateTime createdDate;
  String? completedAt;
  int status;
  int isDeleted;

  TaskHistory(
      {required this.taskId,
      required this.desc,
      required this.startDate,
        required this.todayDate,
      required this.startTime,
      required this.endTime,
      required this.categoryName,
      this.reminder,
      required this.repeatType,
      this.repeatInterval,
      this.repeatTimeUnit,
      required this.priority,
      required this.createdDate,
      this.completedAt,
      this.status = 0,
      required this.isDeleted}); // 0 => pending

  factory TaskHistory.fromMap(Map<String, dynamic> map) {
    return TaskHistory(
      taskId: map['id'] as int,
      desc: map['desc'],
      startDate: DateTime.parse(map['start_date']),
      todayDate: DateTime.parse(map['today_date']),
      startTime: map['start_time'],
      endTime: map['end_time'],
      categoryName: map['categoryName'],
      reminder: map['reminder'],
      repeatType: map['repeat_type'],
      repeatInterval: map['repeat_interval']?? 0,
      repeatTimeUnit: map['repeat_unit'],
      priority: map['priority'],
      createdDate: DateTime.parse(map['created_at']),
      isDeleted: map['is_deleted'] as int,
      completedAt: map['completed_at'],
      status: map['status'] as int,
    );
  }
}
