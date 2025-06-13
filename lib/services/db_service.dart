import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolists/models/app_user_data.dart';
import 'package:todolists/models/category.dart';
import 'package:todolists/models/task.dart';
import 'package:todolists/models/task_history.dart';

class DBService {
  static Database? _db;
  static String _dbName = 'to_do_list.db';
  static String _tblTasks = 'tblTasks';
  static String _tblTasksHistory = 'tblTasksHistory';
  static String _tblCategory = 'tblCategory';
  static String _tblSetting = 'tblSetting';

  Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, _dbName);
    print('Successfully created table');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      //category table
      await db.execute('''
        CREATE TABLE $_tblCategory(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryName TEXT)
      ''');
      //task table

      //enum custom_repeat_unit is for repeat_unit
      await db.execute('''
            CREATE TABLE $_tblTasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            desc TEXT NOT NULL,
            start_date TEXT NOT NULL,
            start_time TEXT NOT NULL,
            end_time TEXT NOT NULL,
            category_id INTEGER,
            reminder TEXT,
            repeat_type TEXT,
            repeat_interval INTEGER,
            repeat_unit INTEGER,
            priority TEXT,
            created_at TEXT NOT NULL,
            is_deleted INTEGER,
            FOREIGN KEY (category_id) REFERENCES $_tblCategory(id) ON DELETE CASCADE
            )
      ''');

      await db.execute('''
        CREATE TABLE $_tblTasksHistory(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         task_id INTEGER,
         date TEXT,
         completed_at TEXT,
         status INTEGER,
         FOREIGN KEY (task_id) REFERENCES $_tblTasks(id) ON DELETE CASCADE
        )
      ''');

      await db.execute('''
        CREATE TABLE $_tblSetting(
        key TEXT PRIMARY KEY,
        value TEXT
        )
      ''');
    });
  }

  Future<void> setSetting({required String key, required String value}) async {
    final db = await _database;
    await db.insert(_tblSetting, {'key': key, 'value': value},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getSetting(String key) async {
    final db = await _database;
    final result =
        await db.query(_tblSetting, where: 'key = ?', whereArgs: [key]);
    if (result.isNotEmpty) {
      return result.first['value'] as String;
    }
    return null;
  }

  Future<int> addNewCategory(Category category) async {
    final db = await _database;
    return db.insert(_tblCategory, category.toMap());
  }

  Future<List<String>> getCategories() async {
    final db = await _database;
    final List<Map<String, Object?>> map = await db.query(_tblCategory);
    // return map.map((ele) => ele['categoryName'] as String).toList();
    return [
      for (final {'categoryName': categoryName as String} in map) categoryName
    ];
  }

  Future<int> addTask(Task task) async {
    final db = await _database;

    return db.insert(_tblTasks, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Future<List<Task>> getAllTasks() async {
  //   final db = await _database;
  //   List<Map<String, dynamic>> map = await db.query(_tblTasks);
  //
  //   return ;
  // }

  Future<void> insertTodayRepeatTasks() async {
    final db = await _database;
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day); // keeps only date
    final todayStr = DateFormat('yyyy-MM-dd').format(today);
    final List<Map<String, dynamic>> repeatTasks = await db.query(
      'tblTasks',
      where: "repeat != ?",
      whereArgs: ['none'],
    );

    for (var task in repeatTasks) {
      final taskId = task['id'];
      final startDateStr = task['start_date'];
      final repeatType = task['repeat'];
      final repeatInterval = task['repeat_interval'] ?? 1;
      final repeatUnit = task['repeat_unit'] ?? 'day';

      DateTime startDate = DateFormat('yyyy-MM-dd').parse(startDateStr);
      Duration difference = today.difference(startDate);

      bool shouldRepeatToday = false;

      if (repeatType == 'Daily') {
        shouldRepeatToday = difference.inDays % repeatInterval == 0;
      } else if (repeatType == 'Weekly') {
        shouldRepeatToday = difference.inDays % (7 * repeatInterval) == 0;
      } else if (repeatType == 'Monthly') {
        shouldRepeatToday = (today.year * 12 +
                        today.month -
                        (startDate.year * 12 + startDate.month)) %
                    repeatInterval ==
                0 &&
            today.day == startDate.day;
      } else if (repeatType == 'Custom') {
        if (repeatUnit == 'Days') {
          shouldRepeatToday = difference.inDays % repeatInterval == 0;
        } else if (repeatUnit == 'Weeks') {
          shouldRepeatToday = difference.inDays % (7 * repeatInterval) == 0;
        } else if (repeatUnit == 'Months') {
          shouldRepeatToday = (today.year * 12 +
                          today.month -
                          (startDate.year * 12 + startDate.month)) %
                      repeatInterval ==
                  0 &&
              today.day == startDate.day;
        }
      }

      if (shouldRepeatToday) {
        final List<Map<String, dynamic>> existing = await db.query(
            _tblTasksHistory,
            where: 'task_id = ? AND date = ?',
            whereArgs: [taskId, startDateStr]);
        if (existing.isEmpty) {
          await db.insert(_tblTasksHistory, {
            'task_id': taskId,
            'date': todayStr,
            'completed_at': null,
            'status': 0,
          });
          print("Successfully inserted history for task id $taskId");
        }
      }
    }
  }

  Future<void> insertMissedRepeatTask() async {
    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    print('inserting task........');
    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

    final db = await _database;
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    final todayStr = DateFormat('yyyy-MM-dd').format(today);
    String? lastRunStr = await getSetting('last_repeat_insert_date');
    DateTime lastRunDate = lastRunStr != null
        ? DateTime.parse(lastRunStr!)
        : today.subtract(Duration(days: 1));

    for (var d = lastRunDate;
        d.isBefore(today) || d.isAtSameMomentAs(today);
        d = d.add(Duration(days: 1))) {
      String dStr = DateFormat('yyyy-MM-dd').format(d);
      final List<Map<String, dynamic>> repeatTasks = await db
          .query(_tblTasks, where: 'repeat_type != ?', whereArgs: ['none']);

      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      print('LastRun Date => $d');
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

      for (var task in repeatTasks) {
        final taskId = task['id'];
        final startDateStr = task['start_date'];
        final repeatType = task['repeat_type'];
        final repeatInterval = task['repeat_interval'] ?? 1;
        final repeatTimeUnit = task['repeat_unit'] ?? 'day';

        DateTime startDate = DateTime.parse(startDateStr);
        Duration diff = d.difference(startDate);
        bool shouldRepeat = false;

        print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
        print('Repeat Task => $taskId ,Start Date => $startDateStr');
        print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

        switch (repeatType) {
          case 'Daily':
            shouldRepeat = diff.inDays % repeatInterval == 0;
            break;
          case 'Weekly':
            shouldRepeat = diff.inDays % (7 * repeatInterval) == 0;
            break;
          case 'Monthly':
            shouldRepeat = (d.year * 12 +
                        d.month -
                        (startDate.year * 12 + startDate.month) %
                            repeatInterval ==
                    0 &&
                d.day == startDate.day);
            break;
          case 'Custom':
            {
              switch (repeatTimeUnit) {
                case ''
                    'Days':
                  shouldRepeat = diff.inDays % repeatInterval == 0;
                  break;
                case 'Weeks':
                  shouldRepeat = diff.inDays % (7 * repeatInterval) == 0;
                  break;
                case 'Months':
                  shouldRepeat = (d.year * 12 +
                              d.month -
                              (startDate.year * 12 + startDate.month) %
                                  repeatInterval ==
                          0 &&
                      d.day == startDate.day);
                  break;
              }
              break;
            }
        }

        if (shouldRepeat) {
          final exits = await db.query(_tblTasksHistory,
              where: 'task_id = ? AND date = ?', whereArgs: [taskId, dStr]);
          if (exits.isEmpty) {
            int id = await db.insert(_tblTasksHistory, {
              'task_id': taskId,
              'date': dStr,
              'completed_at': null,
              'status': 0
            });
            print(
                "Inserted missed repeat task for $taskId on $dStr for id is $id");
          }
        }
      }
    }
    await setSetting(key: 'last_repeat_insert_date', value: todayStr);
  }
}
