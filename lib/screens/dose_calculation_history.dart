import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoseCalculationHistoryScreen extends StatefulWidget {
  const DoseCalculationHistoryScreen({super.key});

  @override
  State<DoseCalculationHistoryScreen> createState() =>
      _DoseCalculationHistoryScreenState();
}

class _DoseCalculationHistoryScreenState
    extends State<DoseCalculationHistoryScreen> {
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('dose_history') ?? [];
    setState(() {
      _history = stored.reversed.toList(); // show newest first
    });
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('dose_history');
    setState(() {
      _history.clear();
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("History cleared")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dose History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: "Clear History",
            onPressed: _history.isEmpty
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text("Clear all saved calculations?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              _clearHistory();
                            },
                            child: const Text("Clear"),
                          ),
                        ],
                      ),
                    );
                  },
          ),
        ],
      ),
      body: _history.isEmpty
          ? const Center(child: Text("No saved calculations"))
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(_history[index]),
                );
              },
            ),
    );
  }
}
