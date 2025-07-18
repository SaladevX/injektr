import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dose_calculation_history.dart';

class DoseCalculatorScreen extends StatefulWidget {
  const DoseCalculatorScreen({super.key});

  @override
  State<DoseCalculatorScreen> createState() => _DoseCalculatorScreenState();
}

class _DoseCalculatorScreenState extends State<DoseCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();

  String _syringeType = 'U-100';
  String _units = '100';
  String _tickMarks = '100';
  final _waterController = TextEditingController();
  final _peptideController = TextEditingController();
  final _desiredDoseController = TextEditingController();

  String _result = '';

  @override
  void initState() {
    super.initState();
    _loadLastResult();
  }

  Future<void> _saveResult(String result) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_calculation_result', result);
  }

  Future<void> _loadLastResult() async {
    final prefs = await SharedPreferences.getInstance();
    final lastResult = prefs.getString('last_calculation_result');
    if (lastResult != null) {
      setState(() {
        _result = lastResult;
      });
    }
  }

  void _calculateDose() {
    final double? water = double.tryParse(_waterController.text);
    final double? peptide = double.tryParse(_peptideController.text);
    final double? desiredMcg = double.tryParse(_desiredDoseController.text);
    final int? tickMarks = int.tryParse(_tickMarks);

    if (water == null ||
        water <= 0 ||
        peptide == null ||
        peptide <= 0 ||
        desiredMcg == null ||
        desiredMcg <= 0 ||
        tickMarks == null ||
        tickMarks <= 0) {
      return;
    }

    // Calculation logic
    final doseMg = desiredMcg / 1000;
    final concentrationPerMl = peptide / water;
    final mlPerDose = doseMg / concentrationPerMl;
    final tickMarkVolume = 1 / tickMarks;
    final tickMarksToUse = mlPerDose / tickMarkVolume;

    setState(() {
      _result = '${tickMarksToUse.toStringAsFixed(1)} tick marks';
    });

    _saveResult(_result);
  }

  Future<void> _saveCalculation() async {
    final prefs = await SharedPreferences.getInstance();

    final result = _result; // assuming _result is your final string result

    if (result.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Nothing to save")));
      return;
    }

    // Load existing history
    final history = prefs.getStringList('dose_history') ?? [];

    // Add the new result (optionally with timestamp)
    history.add("${DateTime.now().toIso8601String()} - $result");

    await prefs.setStringList('dose_history', history);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Calculation saved")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dose Calculator')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Syringe Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _syringeType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: ['U-100', 'U-40']
                  .map(
                    (type) => DropdownMenuItem(value: type, child: Text(type)),
                  )
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _syringeType = val!;
                  _tickMarks = val == 'U-100' ? '100' : '40';
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _units,
              decoration: const InputDecoration(labelText: 'Units'),
              items: ['100', '50', '30']
                  .map(
                    (unit) => DropdownMenuItem(value: unit, child: Text(unit)),
                  )
                  .toList(),
              onChanged: (val) => setState(() => _units = val!),
            ),
            TextFormField(
              initialValue: _tickMarks,
              decoration: const InputDecoration(labelText: 'Tick marks'),
              keyboardType: TextInputType.number,
              validator: (value) {
                final parsed = int.tryParse(value ?? '');
                if (parsed == null || parsed <= 0)
                  return 'Enter valid tick marks';
                return null;
              },
              onChanged: (val) => _tickMarks = val,
            ),
            const SizedBox(height: 16),
            const Text(
              'Vial Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _waterController,
              decoration: const InputDecoration(labelText: 'Water (mL)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                final parsed = double.tryParse(value ?? '');
                if (parsed == null || parsed <= 0)
                  return 'Enter valid water amount';
                return null;
              },
            ),
            TextFormField(
              controller: _peptideController,
              decoration: const InputDecoration(labelText: 'Peptide (mg)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                final parsed = double.tryParse(value ?? '');
                if (parsed == null || parsed <= 0)
                  return 'Enter valid peptide amount';
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Desired Dose',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _desiredDoseController,
              decoration: const InputDecoration(labelText: 'Peptide (mcg)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                final parsed = double.tryParse(value ?? '');
                if (parsed == null || parsed <= 0) return 'Enter valid dose';
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Calculate button takes ~60% of width
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculateDose();
                      }
                    },
                    child: const Text('Calculate'),
                  ),
                ),
                const SizedBox(width: 8),

                // Save button (icon only)
                IconButton(
                  icon: const Icon(Icons.save),
                  tooltip: "Save result",
                  onPressed: _saveCalculation,
                ),

                // History button (icon only)
                IconButton(
                  icon: const Icon(Icons.history),
                  tooltip: "View history",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DoseCalculationHistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Result: $_result',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
