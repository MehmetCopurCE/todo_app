import 'package:intl/intl.dart';

final formatter = DateFormat
    .yMd(); //Tarihi insanların okuyabileceği şekle dönüştürüyor. Bunun için intl package  added

class ToDo {
  final String id;
  final String title;
  final DateTime date;
  final bool isDone;

  ToDo({
    required this.id,
    required this.title,
    required this.date,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': formatter.format(date),
      'isDone' : isDone ? 'true' : 'false',
      // DateTime verisini metin olarak kaydediyoruz
    };
  }

  static ToDo fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      date: formatter.parse(map['date']), // Metni tekrar DateTime olarak dönüştürüyoruz
      isDone: map['isDone'] == 'true',
    );
  }

  String get formattedDate {
    return formatter.format(date);
  }


}