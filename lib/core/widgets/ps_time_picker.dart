import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSpecificTimePicker extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;

  const PlatformSpecificTimePicker({super.key, required this.onTimeSelected});

  @override
  State<PlatformSpecificTimePicker> createState() =>
      _PlatformSpecificTimePickerState();
}

class _PlatformSpecificTimePickerState
    extends State<PlatformSpecificTimePicker> {
  TimeOfDay? _selectedTime;

  Future<void> _showTimePicker(BuildContext context) async {
    TimeOfDay? selectedTime;

    if (Platform.isIOS) {
      selectedTime = await showCupertinoModalPopup<TimeOfDay>(
        context: context,
        builder: (BuildContext builder) {
          return Center(
            child: Container(
              height: 300,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      fontSize: 22, // iOS için metin boyutunu ayarlayın
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedTime = TimeOfDay.fromDateTime(newDateTime);
                    setState(() {
                      _selectedTime = selectedTime;
                    });
                  },
                ),
              ),
            ),
          );
        },
      );
    } else {
      selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    }

    if (selectedTime != null) {
      widget.onTimeSelected(selectedTime!);
      setState(() {
        _selectedTime = selectedTime;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
          child: Row(
            children: [
              Icon(Icons.access_time),
              const SizedBox(width: 5),
              Text(_selectedTime == null
                  ? 'Select time'
                  : _selectedTime!.format(context), style: TextStyle(fontSize: 16)),
            ],
          ),
          onPressed: () {
            _showTimePicker(context);
          });
    }
    return InkWell(
      onTap:() {
        _showTimePicker(context);
      },
      child: Row(
        children: [
          Icon(Icons.access_time),
          const SizedBox(width: 8),
          Text(_selectedTime == null
              ? 'Select time'
              : _selectedTime!.format(context), style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
