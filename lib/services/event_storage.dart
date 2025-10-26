import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/event.dart';

class EventStorage {
  static const _fileName = 'events.json';

  static Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  static Future<List<Event>> loadEvents() async {
    final file = await _getFile();
    if (!await file.exists()) return [];
    final content = await file.readAsString();
    final data = json.decode(content) as List<dynamic>;
    return data.map((e) => Event.fromJson(e)).toList();
  }

  static Future<void> saveEvents(List<Event> events) async {
    final file = await _getFile();
    final jsonData = json.encode(events.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonData);
  }

  static Future<void> deleteEvent(String id) async {
    final events = await loadEvents();
    events.removeWhere((e) => e.id == id);
    await saveEvents(events);
  }
}