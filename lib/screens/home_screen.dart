import 'package:flutter/material.dart';
import '../models/event.dart';
import '../storage/event_storage.dart';
import '../widgets/event_card.dart';
import 'add_event_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final list = await EventStorage.loadEvents();
    setState(() {
      _events = list;
    });
  }

  Future<void> _deleteEvent(String id) async {
    _events.removeWhere((event) => event.id == id);
    await EventStorage.saveEvents(_events);
    setState(() {});
  }

  void _openAddEvent({Event? event}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEventScreen(editingEvent: event),
      ),
    );
    _loadEvents(); // refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Event Planner')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddEvent(),
        child: const Icon(Icons.add),
      ),
      body: _events.isEmpty
          ? const Center(child: Text('Belum ada event'))
          : ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final e = _events[index];
                return EventCard(
                  event: e,
                  onEdit: () => _openAddEvent(event: e),
                  onDelete: () => _deleteEvent(e.id),
                );
              },
            ),
    );
  }
}