import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/components/custom_toast_message.dart';
import 'package:todo_app/core/models/todo.dart';
import 'package:todo_app/core/providers/todo_provider.dart';
import 'package:todo_app/core/storage/database_helper.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
Uuid uuid = const Uuid();

class AddToDoPage extends ConsumerStatefulWidget {
  const AddToDoPage({super.key});

  @override
  ConsumerState<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends ConsumerState<AddToDoPage> {
  DatabaseHelper db = DatabaseHelper.instance;
  final _controller = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void saveItem() async {
    final title = _controller.text;
    if (title.trim().isEmpty || _selectedDate == null || _selectedTime == null) {
      return;
    }
    final id = uuid.v4();

    ref.read(todoProvider.notifier).addTodo(Todo(id: id, title: title, date: _selectedDate!,time: _selectedTime!, isDone: false));

    Navigator.of(context).pop();
    ToastMessage('New Todo added');
  }

  void selectPresentDate() {
    final now = DateTime.now();
    _selectedDate = now;
  }

  Future<void> presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
    ToastMessage('Date picked');
  }

  Future<void> selectTime() async{
    final pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      _selectedTime = pickedTime;
    });
  }

  @override
  void initState() {
    selectPresentDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Add new ToDo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 16, bottom: 8),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter name'),
              ),
              controller: _controller,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [
                  IconButton(
                      onPressed: selectTime,
                      icon: const Icon(Icons.access_time)),
                  Text(_selectedTime == null
                      ? 'Seleck the time'
                      : _selectedTime!.format(context)),
                ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: presentDatePicker,
                        icon: const Icon(Icons.calendar_month)),
                    Text(_selectedDate == null
                        ? 'Select the time'
                        : formatter.format(_selectedDate!)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
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
            )
          ],
        ),
      ),
    );
  }
}
