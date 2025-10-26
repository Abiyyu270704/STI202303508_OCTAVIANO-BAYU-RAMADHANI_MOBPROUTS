import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/event.dart';
import '../services/event_storage.dart';

class AddEventScreen extends StatefulWidget {
  final Event? editingEvent;

  const AddEventScreen({Key? key, this.editingEvent}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.editingEvent != null) {
      _titleController.text = widget.editingEvent!.title;
      _descController.text = widget.editingEvent!.description;
      _selectedDate = widget.editingEvent!.eventDate;
    }
  }

  Future<void> _saveEvent() async {
    final newEvent = Event(
      id: widget.editingEvent?.id ?? const Uuid().v4(),
      title: _titleController.text,
      description: _descController.text,
      eventDate: _selectedDate,
    );

    final events = await EventStorage.loadEvents();

    if (widget.editingEvent != null) {
      final index = events.indexWhere((e) => e.id == widget.editingEvent!.id);
      if (index != -1) events[index] = newEvent;
    } else {
      events.add(newEvent);
    }

    await EventStorage.saveEvents(events);
    if (mounted) Navigator.pop(context, newEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editingEvent == null ? 'Tambah Event' : 'Edit Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul Event'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                    "Tanggal: ${_selectedDate.toLocal().toString().split(' ')[0]}"),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) setState(() => _selectedDate = date);
                  },
                  child: const Text('Pilih Tanggal'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveEvent,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}