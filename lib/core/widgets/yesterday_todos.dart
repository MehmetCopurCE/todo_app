import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/widgets/todo_list.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';

class YesterdayTodoList extends ConsumerWidget {
  final DateTime selectedDate;
  const YesterdayTodoList( {required this.selectedDate,super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider); // todoProvider'dan verileri alın
    String formattedDate = DateFormat.yMd().format(selectedDate.subtract(Duration(days: 1)));

    // Seçilen tarihe sahip görevleri filtreleyin
    List<Todo> selectedDateTodos = todos.where((todo) {
      // Görevin tarihi var mı kontrol edin
      if (todo.date != null) {
        // Görevin tarihi seçilen tarih ile aynı mı kontrol edin
        return DateFormat.yMd().format(todo.date!) == formattedDate;
      }
      return false; // Tarihi olmayan görevleri dikkate almayın
    }).toList();

    return ToDoList(
      todos: selectedDateTodos,
    );
  }
}