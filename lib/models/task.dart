class Task {
  int? id;
  String desc;
  DateTime date;
  String startTime;
  String endTime;
  String? category;
  String? repeat;
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
      this.repeat = 'none',
      this.repeatInterval,
      this.repeatTimeUnit,
      this.reminder,
      this.priority,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'date': date.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
      'category': category,
      'reminder': reminder,
      'repeat': repeat,
      'repeatInterval': repeatInterval,
      'repeatTimeUnit': repeatTimeUnit,
      'priority': priority,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      desc: map['desc'],
      date: DateTime.parse(map['date']),
      startTime: map['start_time'],
      endTime: map['end_time'],
      category: map['category'],
      reminder: map['reminder'],
      repeat: map['repeat'],
      repeatInterval: map['repeatInterval'],
      repeatTimeUnit: map['repeatTimeUnit'],
      priority: map['priority'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
