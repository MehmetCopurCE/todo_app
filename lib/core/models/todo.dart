import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat
    .yMd(); //Tarihi insanların okuyabileceği şekle dönüştürüyor. Bunun için intl package  added

class Todo {
  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': formatter.format(date),
      'time': '${time.hour}:${time.minute}', // Saat verisini metin olarak kaydediyoruz
      'isDone' : isDone ? 'true' : 'false',
      // DateTime verisini metin olarak kaydediyoruz
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      date: formatter.parse(map['date']), // Metni tekrar DateTime olarak dönüştürüyoruz
      time: TimeOfDay(
        hour: int.parse(map['time'].split(':')[0]),
        minute: int.parse(map['time'].split(':')[1]),
      ),
      isDone: map['isDone'] == 'true',
    );
  }

  String get formattedDate {
    return formatter.format(date);
  }


}