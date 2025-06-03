import 'package:todolists/enum/task_status.dart';

class TaskHistory{
  int? id;
  int taskId;
  DateTime date;
  String? completedAt;
  int status;

  TaskHistory({this.id, required this.taskId, required this.date,
    this.completedAt, this.status = 0}); // 0 => pending
}