import 'dart:convert';

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String category;
  final String? mediaPath;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    this.mediaPath,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'category': category,
        'mediaPath': mediaPath,
      };

  factory Event.fromMap(Map<String, dynamic> map) => Event(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        date: DateTime.parse(map['date']),
        category: map['category'],
        mediaPath: map['mediaPath'],
      );

  String toJson() => json.encode(toMap());
  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}