import 'dart:io';
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_storage.dart'; // ✅ perbaiki path

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final list = await EventStorage().readEvents(); // ✅ gunakan readEvents()
    setState(() => _events = list);
  }

  @override
  Widget build(BuildContext context) {
    if (_events.isEmpty) {
      return const Center(child: Text("Belum ada media"));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _events.length,
      itemBuilder: (context, i) {
        final e = _events[i];
        if (e.mediaPath == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: e.mediaPath!.startsWith('http')
                    ? Image.network(e.mediaPath!)
                    : Image.file(File(e.mediaPath!)),
              ),
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: e.mediaPath!.startsWith('http')
                ? Image.network(e.mediaPath!, fit: BoxFit.cover)
                : Image.file(File(e.mediaPath!), fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}