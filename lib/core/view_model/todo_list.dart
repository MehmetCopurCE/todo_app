import 'package:flutter/material.dart';
import 'package:todo_app/core/components/custom_toast_message.dart';
import 'package:todo_app/core/models/toDo.dart';
import 'package:todo_app/core/storage/database_helper.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key, required this.toDos});

  final List<ToDo> toDos;

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  DatabaseHelper db = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.toDos.length,
      itemBuilder: (context, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Dismissible(
            key: ValueKey(widget.toDos[index]),
            onDismissed: (direction) async{
              await db.deleteToDo(widget.toDos[index]);
              setState(() {
                widget.toDos.removeAt(index);
                ToastMessage('Todo Deleted');
              });
            },
            child: ListTile(
                title: Text(widget.toDos[index].title),
                subtitle: Text(widget.toDos[index].formattedDate)),
          ),
        ),
      ),
    );
  }
}
