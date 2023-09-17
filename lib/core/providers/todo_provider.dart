import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/models/todo.dart';
import 'package:todo_app/core/storage/database_helper.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final db = DatabaseHelper.instance;
    final todos = await db.getTodos();
    state = todos;
  }

  Future<void> addTodo(Todo todo) async {
    final db = DatabaseHelper.instance;
    final insertedId = await db.insertTodo(todo);
    if (insertedId != -1) {
      loadTodos(); // Yeni bir görev ekledikten sonra verileri yeniden yükle
    }
  }

  Future<void> updateTodo(Todo todo) async {
    final db = DatabaseHelper.instance;
    final updatedRows = await db.updateTodo(todo);
    if (updatedRows > 0) {
      loadTodos(); // Görev güncellendikten sonra verileri yeniden yükle
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = DatabaseHelper.instance;
    final deletedRows = await db.deleteTodo(todo);
    if (deletedRows > 0) {
      loadTodos(); // Görev silindikten sonra verileri yeniden yükle
    }
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
      (ref) => TodoNotifier(),
);