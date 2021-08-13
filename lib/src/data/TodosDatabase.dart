import 'package:eydev_todos/src/model/TodoModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodosDatabase {
  static Database? _database;
  static final TodosDatabase db = TodosDatabase._();

  TodosDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future _initDB() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'TodosDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Todos('
          ' id INTEGER PRIMARY KEY,'
          ' todo TEXT NOT NULL,'
          ' isCompleted INTEGER NOT NULL,'
          ' finishDate TEXT NOT NULL'
          ')');
    });
  }

  Future<int> newTodo(TodoModel todo) async {
    final Database db = await database;
    final int res = await db.insert('Todos', todo.toJson());
    return res;
  }

  Future<List<TodoModel>> getTodos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> res = await db.query('Todos');

    List<TodoModel> list = res.isNotEmpty ? res.map((s) => TodoModel.fromJson(s)).toList() : [];
    return list;
  }

  Future<int> updateTodo(int id, bool isCompleted) async {
    final Database db = await database;
    Map<String, dynamic> toUpdate = {
      'isCompleted': isCompleted ? 1 : 0,
    };
    final int res = await db.update('Todos', toUpdate, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteTodo(int id) async {
    final Database db = await database;
    final int res = await db.delete('Todos', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteALlTodos() async {
    final Database db = await database;
    final int res = await db.rawDelete("DELETE FROM Todos");
    return res;
  }
}
