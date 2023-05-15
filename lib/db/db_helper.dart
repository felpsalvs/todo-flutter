import 'package:agendamento/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../main.dart';

class DBHelper {
  static late Database _db;

  static Future<void> initialize() async {
    try {
      sqflite_ffi.sqfliteInit();
      databaseFactory = databaseFactoryFfi;

      final String path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute('CREATE TABLE tasks ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title STRING, note TEXT, date STRING, '
          'startTime STRING, endTime STRING, '
          'remind INTEGER, repeat STRING, '
          'color INTEGER, '
          'isCompleted INTEGER)');
      });
    } catch (e) {
      throw Exception('Failed to initialize database: $e');
    }
  }

  static Future<int> insert(Task? task) async {
    return await _db.insert('tasks', task!.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db.query('tasks');
  }

  static Future<int> delete(Task task) async {
    return await _db.delete('tasks', where: 'id=?', whereArgs: [task.id]);
  }

  static initDb() {}
}

void main() async {
  // Inicializar o banco de dados
  await DBHelper.initialize();

  runApp(MyApp());
}
