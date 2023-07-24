import 'package:flutter/material.dart';
import 'package:todo_app/core/models/toDo.dart';
import 'package:todo_app/core/views/add_new_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDo> toDos = [
    ToDo(title: 'Todo 1'),
    ToDo(title: 'Todo 1'),
  ];
  

  Future<void> _addItem() async {
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
      body: ListView.builder(
        itemCount: toDos.length,
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(toDos[index].title),
            ),
          ),
        ),
      ),
    );
  }
}
