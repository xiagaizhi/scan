import 'package:scan/sql/base_table.dart';

class SqlHelper {
  static Future<int> insert(BaseTable table, Map<String, dynamic> map) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    List<Map<String, dynamic>> list =
        await query(table, map["${table.getPrimaryString()}"].toString());
    if (list.length != 0) {
      print("---------------------重复添加----------------------");
      return -1;
    }
    return await db.insert(name, map);
  }

  static Future<List<Map<String, dynamic>>> query(
      BaseTable table, String taskItemId) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.query(name,
        where: "${table.getPrimaryString()} = ?", whereArgs: [taskItemId]);
  }

  static Future<List<Map<String, dynamic>>> queryAll(BaseTable table) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.query(name);
  }

  static Future<int> update(BaseTable table, Map<String, dynamic> map) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.update(name, map,
        where: "${table.getPrimaryString()}=?",
        whereArgs: [map["${table.getPrimaryString()}"]]);
  }

  static Future<int> delete(BaseTable table, int id) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.rawDelete('DELETE FROM $name WHERE $id = $id');
  }

  static Future<int> deleteByColumn(
      BaseTable table, String columnName, dynamic columnId) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db
        .rawDelete('DELETE FROM $name WHERE $columnName = $columnId');
  }

  static Future<int> deleteAll(BaseTable table) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.delete(name);
  }
}
