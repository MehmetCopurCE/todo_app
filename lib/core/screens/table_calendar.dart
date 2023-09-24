import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/core/providers/todo_provider.dart';
import 'package:todo_app/core/widgets/todo_item.dart';

import '../models/todo.dart';

class TableCalendarPage extends ConsumerStatefulWidget {
  const TableCalendarPage({super.key});

  @override
  ConsumerState<TableCalendarPage> createState() => _TableCalendarPageState();
}

class _TableCalendarPageState extends ConsumerState<TableCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? firstDay;
  DateTime? lastDay;

  @override
  void initState() {
    _selectedDay = _focusedDay;
    firstDay =
        DateTime(_focusedDay.year, _focusedDay.month - 3, _focusedDay.day);
    lastDay =
        DateTime(_focusedDay.year, _focusedDay.month + 3, _focusedDay.day);

    super.initState();
  }

  List<Todo> _getEventsForDay(DateTime day) {
    // Burada, belirtilen gün için todos listesini filtreleyebilirsiniz.
    final todosForDay = ref.watch(todoProvider).where((todo) =>
        todo.date.year == day.year &&
        todo.date.month == day.month &&
        todo.date.day == day.day);

    return todosForDay
        .map((todo) => Todo(
              date: todo.date,
              id: todo.id,
              isDone: todo.isDone,
              time: todo.time,
              title: todo.title,
            ))
        .toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  List<Todo> getTodosByDay(List<Todo> todoList, DateTime selectedDay) {
    return todoList.where((todo) {
      final todoDate = todo.date;
      return todoDate.year == selectedDay.year &&
          todoDate.month == selectedDay.month &&
          todoDate.day == selectedDay.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> todos = ref.watch(todoProvider);
    final filteredTodos = getTodosByDay(todos, _selectedDay!);
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Event'),
      ),
      body: Column(
        children: [
          TableCalendar<Todo>(
            focusedDay: _focusedDay,
            firstDay: firstDay!,
            lastDay: lastDay!,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: true,
            ),
            eventLoader: _getEventsForDay,
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 16),
          if(filteredTodos.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text('There is nothing to do'),
            ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredTodos.length,
                itemBuilder: (context, index) => TodoItem(todo: filteredTodos[index])),
          ),
        ],
      ),
    );
  }
}
