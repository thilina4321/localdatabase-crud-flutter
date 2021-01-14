import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> db() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo3.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE DataD (id INTEGER PRIMARY KEY, name TEXT, age TEXT)');
    });

    return database;
  }

  static Future<void> insert(Map<String, Object> data) async {
    final database = await DBHelper.db();

    await database.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO DataD(name, age) VALUES("${data['name']}", "${data['age']}")');
    });
  }

  static Future<List<Map<String, dynamic>>> fetch() async {
    final database = await DBHelper.db();
    final data = await database.rawQuery('SELECT * FROM DataD');
    return data;
  }

  static Future<void> delete(id) async {
    final database = await DBHelper.db();
    final data = await database.rawDelete('DELETE FROM DataD WHERE id = $id');
    return data;
  }

  static Future<void> update(Map<String, Object> updateData) async {
    final database = await DBHelper.db();
    final data = await database.rawUpdate(
        'UPDATE DataD SET name = ?, age = ? WHERE id = ?', [
      '${updateData['name']}',
      '${updateData['age']}',
      '${updateData['id']}'
    ]);
    return data;
  }
}
