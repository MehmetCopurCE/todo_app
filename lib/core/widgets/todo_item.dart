import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/models/toDo.dart';
import 'package:todo_app/core/providers/todo_provider.dart';

import '../components/custom_toast_message.dart';

class TodoItem extends ConsumerStatefulWidget {
  const TodoItem({required this.todo, super.key});

  final ToDo todo;

  @override
  ConsumerState<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  void deleteToDo(ToDo todo) async {
    ref.read(todoProvider.notifier).deleteTodo(todo);
    ToastMessage('Todo deleted successfully');
  }

  @override
  Widget build(BuildContext context) {
    bool isDone = widget.todo.isDone;
    return ListTile(
      leading: Checkbox(
        value: isDone,
        onChanged: (value) {
          isDone = value!;
          ref.read(todoProvider.notifier).updateTodo(ToDo(
              id: widget.todo.id,
              title: widget.todo.title,
              date: widget.todo.date,
              isDone: isDone));
        },
      ),
      title: Text(widget.todo.title,
          style: widget.todo.isDone
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 1.5)
              : null),
      trailing: IconButton(
        onPressed: () => deleteToDo(widget.todo),
        icon: Icon(Icons.delete),
      ),
    );
  }
}
