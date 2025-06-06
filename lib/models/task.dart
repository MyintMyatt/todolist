class Task {
  int? id;
  String desc;
  DateTime date;
  String startTime;
  String endTime;
  String? category;
  String repeatType;
  int? repeatInterval;
  int? repeatTimeUnit;
  String? reminder;
  String? priority;

  DateTime createdAt;

  Task(
      {this.id,
      required this.desc,
      required this.date,
      required this.startTime,
      required this.endTime,
      this.category,
      this.repeatType = 'none',
      this.repeatInterval = 1,
      this.repeatTimeUnit,
      this.reminder,
      this.priority,
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
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
