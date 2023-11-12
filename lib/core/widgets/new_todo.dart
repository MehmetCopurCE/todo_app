import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/widgets/ps_time_picker.dart';
import 'package:uuid/uuid.dart';

import '../components/custom_toast_message.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../storage/database_helper.dart';
import 'ps_date_picker.dart';

final formatter = DateFormat.yMd();
Uuid uuid = const Uuid();

class NewTodo extends ConsumerStatefulWidget {
  const NewTodo({super.key});

  @override
  ConsumerState<NewTodo> createState() => _AddWidgetsState();
}

class _AddWidgetsState extends ConsumerState<NewTodo> {
  DatabaseHelper db = DatabaseHelper.instance;
  final _controller = TextEditingController();

   DateTime? _selectedDate;
   TimeOfDay? _selectedTime;

  void saveItem() async {
    final title = _controller.text;
    if (title.trim().isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      return;
    }
    final id = uuid.v4();

    ref.read(todoProvider.notifier).addTodo(Todo(
        id: id,
        title: title,
        date: _selectedDate!,
        time: _selectedTime!,
        isDone: false));

    Navigator.of(context).pop();
    ToastMessage('New Todo added');
  }

  // void selectPresentDate() {
  //   final now = DateTime.now();
  //   final currentTime = TimeOfDay(hour: now.hour + 2, minute: now.minute);
  //   _selectedTime = currentTime;
  //   _selectedDate = now;
  // }

  void onDateSelected(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void onTimeSelected(TimeOfDay selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
    });
  }

  @override
  void initState() {
    //selectPresentDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 16, bottom: 8),
      child: Column(
        children: [
          Platform.isIOS
              ? CupertinoTextField(
                  controller: _controller,
                  placeholder: "helllllooooooo",
                )
              : TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter name'),
                  ),
                  controller: _controller,
                ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlatformSpecificTimePicker(onTimeSelected: onTimeSelected),
              const SizedBox(width: 15),
              PlatformSpecificDatePicker(onDateSelected: onDateSelected),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    _controller.clear();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: saveItem,
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
