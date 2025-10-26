import 'dart:io';
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/storage_service.dart';
import 'add_event_screen.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await StorageService().deleteEvent(event.id);
              if (context.mounted) Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEventScreen(editingEvent: event),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (event.mediaPath != null && event.mediaPath!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: event.mediaPath!.startsWith('http')
                    ? Image.network(event.mediaPath!, fit: BoxFit.cover)
                    : Image.file(File(event.mediaPath!), fit: BoxFit.cover),
              ),
            Text(event.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Kategori: ${event.category}',
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text('Tanggal: ${event.date.toLocal()}'),
            const SizedBox(height: 16),
            Text(event.description),
          ],
        ),
      ),
    );
  }
}