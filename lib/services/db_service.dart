import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolists/models/app_user_data.dart';

class DBService {
  static Database? _db;
  static String _dbName = 'to_do_list.db';
  static String _userTblName = 'tblUser';

  Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath,_dbName);
    print('Successfully created table');
    return await openDatabase(path,version: 1,onCreate: (db,version) async{
      await db.execute('''
            CREATE TABLE $_userTblName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userName TEXT,
            gender TEXT,
            occupation TEXT,
            birthday TEXT,
            age INTEGER
            )
      ''');
    });
  }
  Future<int> registerUser(AppUserData user)async{
      final db = await _database;
      return db.insert(_userTblName, user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
