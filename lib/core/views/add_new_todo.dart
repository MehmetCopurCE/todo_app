import 'package:flutter/material.dart';
import 'package:todo_app/core/components/custom_toast_message.dart';
import 'package:todo_app/core/models/toDo.dart';

class AddToDoPage extends StatefulWidget {
  const AddToDoPage({super.key});

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void saveItem() {
      final title = _controller.text;
      if (title.trim().isEmpty) {
        return;
      }

      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop(
        ToDo(title: title),
      );

      ToastMessage('New Todo added');
    }

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
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: saveItem,
                  child: Text('Add'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
