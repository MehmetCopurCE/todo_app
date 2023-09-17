import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/components/custom_toast_message.dart';
import 'package:todo_app/core/models/todo.dart';
import 'package:todo_app/core/providers/todo_provider.dart';
import 'package:todo_app/core/storage/database_helper.dart';
import 'package:todo_app/core/widgets/todo_item.dart';

class ToDoList extends ConsumerStatefulWidget {
  const ToDoList({
    super.key,
    required this.todos,
  });

  final List<Todo> todos;

  @override
  ConsumerState<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends ConsumerState<ToDoList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (context, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TodoItem(todo: widget.todos[index]),
        ),
      ),
    );
  }
}
