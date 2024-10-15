import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'quejas.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE quejas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        mensaje TEXT,
        FOREIGN KEY (userId) REFERENCES usuarios (id)
      )
    ''');
  }
}
