import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/components/custom_toast_message.dart';
import 'package:todo_app/core/models/toDo.dart';
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

  void saveItem() async {
    final title = _controller.text;
    if (title.trim().isEmpty || _selectedDate == null) {
      return;
    }
    final id = uuid.v4();

    ref.read(todoProvider.notifier).addTodo(ToDo(id: id, title: title, date: _selectedDate!));

    //
    // ///sql kaydetme
    // await db.insertToDo(ToDo(id : id ,title: title, date: _selectedDate!));
    // setState(() {});
    //
    // if (!context.mounted) {
    //   return;
    // }
    // Navigator.of(context).pop(
    //   ToDo(id : id, title: title, date: _selectedDate!),
    //);
    Navigator.of(context).pop();
    ToastMessage('New Todo added');
  }

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
    ToastMessage('Date picked');
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: presentDatePicker,
                    icon: const Icon(Icons.calendar_month)),
                Text(_selectedDate == null
                    ? 'Seleck the time'
                    : formatter.format(_selectedDate!)),
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