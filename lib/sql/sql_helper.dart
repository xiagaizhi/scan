import 'package:scan/sql/base_table.dart';

class SqlHelper {
  static Future<int> insert(BaseTable table, Map<String, dynamic> map) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.insert(name, map);
  }

  static Future query(BaseTable table, int id) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.rawQuery("select * from $name where id = $id");
  }

  static Future<List<Map<String, dynamic>>> queryAll(BaseTable table) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.query(name);
  }

  static Future<int> update(BaseTable table, Map<String, dynamic> map) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.update(name, map);
  }

  static Future<int> delete(BaseTable table, int id) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.rawDelete('DELETE FROM $name WHERE $id = $id');
  }
  static Future<int> deleteAll(BaseTable table) async {
    var db = await table.getDataBase();
    var name = table.tableName();
    return await db.delete(name);
  }
}
