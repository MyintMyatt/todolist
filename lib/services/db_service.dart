import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolists/models/app_user_data.dart';
import 'package:todolists/models/category.dart';
import 'package:todolists/models/task.dart';

class DBService {
  static Database? _db;
  static String _dbName = 'to_do_list.db';
  static String _tblTasks = 'tblTasks';
  static String _tblTasksHistory = 'tblTasksHistory';
  static String _tblCategory = 'tblCategory';

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
            date TEXT NOT NULL,
            start_time TEXT NOT NULL,
            end_time TEXT NOT NULL,
            category_id INTEGER,
            reminder TEXT,
            repeat TEXT,
            repeat_interval INTEGER,
            repeat_unit INTEGER,
            priority TEXT,
            created_at TEXT NOT NULL,
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

    });
  }

  Future<int> addNewCategory(Category category) async {
    final db = await _database;
    return db.insert(_tblCategory, category.toMap());
  }

  Future<List<String>> getCategories() async {
    final db = await _database;
    print('get category');
    final List<Map<String, Object?>> map = await db.query(_tblCategory);
   // return map.map((ele) => ele['categoryName'] as String).toList();
    return [
      for (final {'categoryName': categoryName as String}
          in map)
        categoryName
    ];
  }

  Future<int> addTask(Task task) async {
    final db = await _database;

    return db.insert(_tblTasks, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
