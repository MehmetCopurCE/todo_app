import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/components/custom_toast_message.dart';
import 'package:todo_app/core/models/todo.dart';
import 'package:todo_app/core/providers/todo_provider.dart';
import 'package:todo_app/core/screens/add_new_todo.dart';
import 'package:todo_app/core/storage/database_helper.dart';
import 'package:todo_app/core/widgets/todo_list.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  DatabaseHelper db = DatabaseHelper.instance;

  // ///Dummy datas
  // List<ToDo> toDos = [
  //   // ToDo(title: 'Todo 1', date: DateTime.now()),
  //   // ToDo(title: 'Todo 1', date: DateTime.now()),
  // ];

  // Future<void> _loadToDos() async {
  //   List<ToDo> _todos = [];
  //   _todos = await db.getToDos();
  //
  //   setState(() {
  //     toDos = _todos;
  //   });
  // }

  @override
  void initState() {
    // _loadToDos();
    super.initState();
  }

  void _addItem() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddToDoPage(),
    ));
    // final newToDo = await Navigator.of(context).push<ToDo>(MaterialPageRoute(
    //   builder: (context) => const AddToDoPage(),
    // ));

    // if (newToDo == null) {
    //   return;
    // }

    // setState(() {
    //   toDos.add(newToDo!);
    // });
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> todos = ref.watch(todoProvider);
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
      body: todos.isEmpty
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Image.asset('assets/images/img_todo.jpg'),
              ),
          )
          : Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/img_todo.jpg'))
              ),
              child: ToDoList(
                todos: todos,
              ),
            ),
    );
  }
}
