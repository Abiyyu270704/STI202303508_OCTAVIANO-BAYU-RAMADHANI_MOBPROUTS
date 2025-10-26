import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/event.dart';

class EventStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/events.json');
  }

  static Future<List<Event>> loadEvents() async {
    try {
      final file = await _localFile;

      if (!await file.exists()) return [];

      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((data) => Event.fromJson(data)).toList();
    } catch (e) {
      print("Error loading events: $e");
      return [];
    }
  }

  static Future<void> saveEvents(List<Event> events) async {
    final file = await _localFile;
    final data = events.map((e) => e.toJson()).toList();
    await file.writeAsString(json.encode(data));
  }
}