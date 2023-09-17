import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/models/toDo.dart';
import 'package:todo_app/core/storage/database_helper.dart';

class TodoNotifier extends StateNotifier<List<ToDo>> {
  TodoNotifier() : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final db = DatabaseHelper.instance;
    final todos = await db.getToDos();
    state = todos;
  }

  Future<void> addTodo(ToDo todo) async {
    final db = DatabaseHelper.instance;
    final insertedId = await db.insertToDo(todo);
    if (insertedId != -1) {
      loadTodos(); // Yeni bir görev ekledikten sonra verileri yeniden yükle
    }
  }

  Future<void> updateTodo(ToDo todo) async {
    final db = DatabaseHelper.instance;
    final updatedRows = await db.updateToDo(todo);
    if (updatedRows > 0) {
      loadTodos(); // Görev güncellendikten sonra verileri yeniden yükle
    }
  }

  Future<void> deleteTodo(ToDo todo) async {
    final db = DatabaseHelper.instance;
    final deletedRows = await db.deleteToDo(todo);
    if (deletedRows > 0) {
      loadTodos(); // Görev silindikten sonra verileri yeniden yükle
    }
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<ToDo>>(
      (ref) => TodoNotifier(),
);