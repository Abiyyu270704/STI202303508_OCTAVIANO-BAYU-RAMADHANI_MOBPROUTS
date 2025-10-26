import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_storage.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onDelete;

  const EventCard({super.key, required this.event, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "${event.description}\n${event.eventDate.toLocal().toString().split(' ')[0]}",
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            await EventStorage.deleteEvent(event.id);
            onDelete();
          },
        ),
      ),
    );
  }
}