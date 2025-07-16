import 'package:flutter/material.dart';
import '../models/dose_entry.dart';
import '../services/dose_service.dart';

class DoseLogScreen extends StatefulWidget {
  const DoseLogScreen({super.key});

  @override
  State<DoseLogScreen> createState() => _DoseLogScreenState();
}

class _DoseLogScreenState extends State<DoseLogScreen> {
  final _doseService = DoseService();
  List<DoseEntry> entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    await _doseService.init();
    setState(() {
      entries = _doseService.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dose Log')),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          return ListTile(
            title: Text('${entry.doseMg} mg @ ${entry.injectionSite}'),
            subtitle: Text('${entry.date.toLocal()} - ${entry.weight} lbs'),
            trailing: Icon(entry.hasISR ? Icons.warning : Icons.check_circle),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // next: implement form to add dose
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
