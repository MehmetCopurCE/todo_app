import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/custom_toast_message.dart';
import '../models/todo.dart';

class PlatformSpecificDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const PlatformSpecificDatePicker({super.key, required this.onDateSelected});

  @override
  State<PlatformSpecificDatePicker> createState() =>
      _PlatformSpecificDatePickerState();
}

class _PlatformSpecificDatePickerState
    extends State<PlatformSpecificDatePicker> {
  DateTime? _selectedDate;

  Future<void> presentDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1);

    if (Platform.isIOS) {
      final pickedDate = await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: now,
              minimumDate: firstDate,
              maximumDate: lastDate,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
          );
        },
      );

      if (pickedDate != null) {
        ToastMessage('Date picked');
      }
    } else {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate,
      );

      if (pickedDate != null) {
        setState(() {
          widget.onDateSelected(pickedDate);
          _selectedDate = pickedDate;
        });
        ToastMessage('Date picked');
      }
    }
  }

  @override
  void initState() {
    selectPresentDate();
    super.initState();
  }

  void selectPresentDate() {
    final now = DateTime.now();
    _selectedDate = now;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
          child: Row(
            children: [
              Icon(Icons.calendar_month),
              const SizedBox(width: 5),
              Text(
                  _selectedDate == null
                      ? 'Select date'
                      : formatter.format(_selectedDate!),
                  style: TextStyle(fontSize: 16)),
            ],
          ),
          onPressed: () {
            setState(() {
              presentDatePicker(context);
            });
          });
    }
    return InkWell(
      onTap: () {
        presentDatePicker(context);
      },
      child: Row(
        children: [
          Icon(Icons.calendar_month),
          const SizedBox(width: 8),
          Text(
            _selectedDate == null
                ? 'Select date'
                : formatter.format(_selectedDate!),
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
