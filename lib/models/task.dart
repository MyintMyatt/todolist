class Task {
  int? id;
  String desc;
  DateTime date;
  String startTime;
  String endTime;
  String? category;
  String repeatType;
  int? repeatInterval;
  String? repeatTimeUnit;
  String? reminder;
  String? priority;
  int? isDeleted;

  DateTime createdAt;

  Task(
      {this.id,
      required this.desc,
      required this.date,
      required this.startTime,
      required this.endTime,
      this.category,
      this.repeatType = 'None',
      this.repeatInterval = 1,//1 day, 2 week, 3months
      this.repeatTimeUnit,//day, month, week
      this.reminder,
      this.priority,
        this.isDeleted = 0,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'start_date': date.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
      'category': category,
      'reminder': reminder,
      'repeat_type': repeatType,
      'repeat_interval': repeatInterval,
      'repeat_unit': repeatTimeUnit,
      'priority': priority,
      'is_deleted':isDeleted,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      desc: map['desc'],
      date: DateTime.parse(map['start_date']),
      startTime: map['start_time'],
      endTime: map['end_time'],
      category: map['category'],
      reminder: map['reminder'],
      repeatType: map['repeat_type'],
      repeatInterval: map['repeat_interval'],
      repeatTimeUnit: map['repeat_unit'],
      priority: map['priority'],
      isDeleted: map['is_deleted'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
