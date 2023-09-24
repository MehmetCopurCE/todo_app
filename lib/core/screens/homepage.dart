import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/models/todo.dart';
import 'package:todo_app/core/providers/todo_provider.dart';
import 'package:todo_app/core/screens/add_new_todo.dart';
import 'package:todo_app/core/screens/table_calendar.dart';
import 'package:todo_app/core/widgets/today_todos.dart';
import 'package:todo_app/core/widgets/tomorrow_todos.dart';
import 'package:todo_app/core/widgets/yesterday_todos.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends ConsumerState<HomePage> {
  late DateTime dateTime;

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTodayAndMonth = DateFormat("d MMMM").format(dateTime);
    String formattedYesterdayAndMonth =
        DateFormat("d MMMM").format(dateTime.subtract(Duration(days: 1)));
    String formattedTomorrowAndMonth =
        DateFormat("d MMMM").format(dateTime.add(Duration(days: 1)));

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ToDo App',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TableCalendarPage()));
              },
              icon: Icon(Icons.calendar_month)),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddToDoPage(),
                ));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 26,
              ),
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(child: Text(formattedYesterdayAndMonth)),
            Tab(child: Text(formattedTodayAndMonth)),
            Tab(child: Text(formattedTomorrowAndMonth))
          ]),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/img_todo.jpg'))),
          child: TabBarView(
            children: [
              YesterdayTodoList(selectedDate: dateTime),
              TodayTodoList(selectedDate: dateTime),
              TomorrowTodoList(selectedDate: dateTime),
            ],
          ),
        ),
      ),
    );
  }
}
