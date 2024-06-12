import '../models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}tasks.db';
      _db =
      await openDatabase(path, version: _version, onCreate: (db, version) {
        print("creating a new one");
        return db.execute("CREATE TABLE $_tableName("
            " id INTEGER PRIMARY KEY AUTOINCREMENT , "
            " title STRING, desc TEXT, date STRING , "
            " isCompleted STRING )");
      });
    } catch (e) {
      print(e);
    }
  }
  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName);
  }



  static Future<int> insert(TaskOffline? taskofline) async {
    print("insert function called");
    return await _db?.insert(_tableName, taskofline!.toJson()) ?? 1;
  }

  // static updateData(
  //     int id,
  //     String title,
  //     String desc,
  //     ) async {
  //   print("Update function called");
  //   return await _db!.rawUpdate('''
  //    UPDATE tasks
  //   SET title = ?, desc = ?
  //   WHERE id=?
  //    ''', [title, desc, id]);
  // }

  // static update(int id) async {
  //   return await _db!.rawUpdate('''
  //    UPDATE tasks
  //   SET isCompleted = ?
  //   WHERE id=?
  //    ''', [1, id]);
  // }
  //

  // static delete(TaskOffline taskofline) async {
  //   await _db!.delete(_tableName, where: 'id=?', whereArgs: [taskofline.id]);
  // }

static deleteTable()async{
    await _db!.delete(_tableName);
}
}
