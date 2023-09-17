import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/components/custom_toast_message.dart';
import 'package:todo_app/core/models/toDo.dart';
import 'package:todo_app/core/providers/todo_provider.dart';
import 'package:todo_app/core/storage/database_helper.dart';

class ToDoList extends ConsumerStatefulWidget {
  const ToDoList({
    super.key,
    required this.todos,
  });

  final List<ToDo> todos;

  @override
  ConsumerState<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends ConsumerState<ToDoList> {
  void deleteToDo(ToDo todo) async {
    ref.read(todoProvider.notifier).deleteTodo(todo);
    ToastMessage('Todo deleted successfully');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (context, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(widget.todos[index].title),
            trailing: IconButton(
              onPressed: () => deleteToDo(widget.todos[index]),
              icon: Icon(Icons.delete),
            ),
          ),
        ),
      ),
    );
  }
}
