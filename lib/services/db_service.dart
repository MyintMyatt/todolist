import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolists/models/app_user_data.dart';
import 'package:todolists/models/category.dart';
import 'package:todolists/models/task.dart';

class DBService {
  static Database? _db;
  static String _dbName = 'to_do_list.db';
  static String _tblName = 'tblTasks';
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
      await db.execute('''
            CREATE TABLE $_tblName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            desc TEXT NOT NULL,
            start_time TEXT NOT NULL,
            end_time TEXT NOT NULL,
            category TEXT,
            reminder TEXT,
            repeat TEXT,
            repeat_interval INTEGER,
            repeat_unit TEXT,
            priority TEXT,
            status TEXT NOT NULL,
            created_at TEXT NOT NULL
            )
      ''');
      await db.execute('''
        CREATE TABLE $_tblCategory(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryName TEXT)
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
    print('Inserting task in db......');
    return db.insert(_tblName, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
