import 'package:flutter/material.dart';
import 'package:scan/sql/sql_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseTable {
  bool isTableExits = false;

  createTableString();

  tableName();

  tableBaseString(String sql) {
    return sql;
  }

  Future<Database> getDataBase() async {
    return await open();
  }
  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await SqlManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), createTableString());
    }
    return await SqlManager.getCurrentDatabase();
  }
}
