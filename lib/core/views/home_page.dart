import 'package:flutter/material.dart';
import 'package:todo_app/core/components/custom_toast_message.dart';
import 'package:todo_app/core/models/toDo.dart';
import 'package:todo_app/core/storage/database_helper.dart';
import 'package:todo_app/core/view_model/todo_list.dart';
import 'package:todo_app/core/views/add_new_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper db = DatabaseHelper.instance;

  ///Dummy datas
  List<ToDo> toDos = [
    // ToDo(title: 'Todo 1', date: DateTime.now()),
    // ToDo(title: 'Todo 1', date: DateTime.now()),
  ];

  Future<void> _loadToDos() async {
    List<ToDo> _todos = [];
    _todos = await db.getToDos();

    setState(() {
      toDos = _todos;
    });
  }

  @override
  void initState() {
    _loadToDos();
    super.initState();
  }

  void _addItem() async {
    final newToDo = await Navigator.of(context).push<ToDo>(MaterialPageRoute(
      builder: (context) => const AddToDoPage(),
    ));

    if (newToDo == null) {
      return;
    }

    setState(() {
      toDos.add(newToDo!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ToDo App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadToDos,
        child: ToDoList(toDos: toDos),
      ),
    );
  }
}
