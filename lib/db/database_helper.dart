import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, isCompleted INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final db = await database;
    return db.query('tasks');
  }

  Future<int> addTask(Map<String, dynamic> task) async {
    final db = await database;
    return db.insert('tasks', task);
  }

  Future<int> updateTask(Map<String, dynamic> task, int id) async {
    final db = await database;
    return db.update('tasks', task, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
