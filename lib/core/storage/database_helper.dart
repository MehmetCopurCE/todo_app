import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/core/components/custom_toast_message.dart';
import 'package:todo_app/core/models/todo.dart';

final formatter = DateFormat.yMd();

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  static const String tableName = 'todos';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnDate = 'date';
  static const String columnTime = 'time';
  static const String columnIsDone = 'isDone';

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "todos.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId TEXT NOT NULL,
        $columnTitle TEXT NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnTime TEXT NOT NULL,
        $columnIsDone TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertTodo(Todo toDo) async {
    final db = await database;
    int insertedId = -1; // Başlangıçta geçersiz bir ID değeri belirliyoruz.

    try {
      insertedId = await db!.insert( tableName, toDo.toMap());
    } catch (e) {
      debugPrint('Hata: ${e.toString()}');
    }

    if (insertedId != -1) {
      debugPrint('New todo added to db. ID: $insertedId');
    } else {
      debugPrint('Todo addition to db failed.');
    }

    return insertedId; // Ekleme başarılıysa eklenen verinin ID değerini döndürüyoruz.
  }


  Future<int> updateTodo(Todo toDo) async {
    final db = await database;
    try {
      return await db!.update(
        tableName,
        toDo.toMap(),
        where: '$columnId = ?',
        whereArgs: [toDo.id],
      );

    } catch (e) {
      debugPrint('Update failed: ${e.toString()}');
      return -1; // Başarısızlık durumunda -1 döndürebiliriz.
    }
  }

  Future<int> deleteTodo(Todo todo) async {
    final db = await database;
    try {
      return await db!.delete(
        tableName,
        where: '$columnId = ?',
        whereArgs: [todo.id],
      );
    } catch (e) {
      debugPrint('Delete failed: ${e.toString()}');
      return -1; // Başarısızlık durumunda -1 döndürebiliriz.
    }
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    try {
      var toDosMapList = await db!.query(tableName, orderBy: '$columnDate ASC, $columnTime ASC');
      return toDosMapList.map((toDoMap) => Todo.fromMap(toDoMap)).toList();
    } catch (e) {
      debugPrint('Get todos failed: ${e.toString()}');
      return []; // Başarısızlık durumunda boş bir liste döndürebiliriz.
    }
  }


}