import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/models/todo.dart';
import 'package:todo_app/core/providers/todo_provider.dart';

import '../components/custom_toast_message.dart';

class TodoItem extends ConsumerStatefulWidget {
  const TodoItem({required this.todo, super.key});

  final Todo todo;

  @override
  ConsumerState<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  void deleteToDo(Todo todo) async {
    ref.read(todoProvider.notifier).deleteTodo(todo);
    ToastMessage('Todo deleted successfully');
  }

  Color? checkTodo(Todo todo) {
    bool isDone = todo.isDone;
    DateTime now = DateTime.now();
    DateTime todoDateTime = DateTime(todo.date.year, todo.date.month, todo.date.day, todo.time.hour, todo.time.minute);

    if (isDone) {
      return Colors.green.shade300;
    } else if (todoDateTime.isBefore(now) && !isDone) {
      return Colors.red.shade300;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDone = widget.todo.isDone;
    return Card(
      color: checkTodo(widget.todo),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Checkbox(
            value: isDone,
            onChanged: (value) {
              isDone = value!;
              ref.read(todoProvider.notifier).updateTodo(Todo(
                  id: widget.todo.id,
                  title: widget.todo.title,
                  date: widget.todo.date,
                  time: widget.todo.time,
                  isDone: isDone));
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.todo.title,
                  style: widget.todo.isDone
                      ? TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2)
                      : null
              ),
              Text(widget.todo.time.format(context)),
              //Text(formatter.format(widget.todo.date)),
            ],
          ),
          // trailing: IconButton(
          //   onPressed: () => deleteToDo(widget.todo),
          //   icon: Icon(Icons.delete),
          // ),
        ),
      ),
    );
  }
}
