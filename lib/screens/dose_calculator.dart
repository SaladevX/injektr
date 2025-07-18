import 'package:flutter/material.dart';

class DoseCalcScreen extends StatefulWidget {
  const DoseCalcScreen({super.key});

  @override
  State<DoseCalcScreen> createState() => _DoseCalcScreenState();
}

class _DoseCalcScreenState extends State<DoseCalcScreen> {
  // Syringe section
  String _selectedSyringeType = 'U-100';
  String _selectedUnits = '100';
  final _tickMarksController = TextEditingController();

  // Vial section
  final _waterController = TextEditingController();
  final _peptideMgController = TextEditingController();

  // Desired dose
  final _desiredMcgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateDefaultTickMarks(); // set initial value
  }

  void _updateDefaultTickMarks() {
    if (_selectedSyringeType == 'U-100') {
      _tickMarksController.text = '100';
    } else if (_selectedSyringeType == 'U-40') {
      _tickMarksController.text = '40';
    }
  }

  @override
  void dispose() {
    _tickMarksController.dispose();
    _waterController.dispose();
    _peptideMgController.dispose();
    _desiredMcgController.dispose();
    super.dispose();
  }

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );

  Widget _dropdownField<T>({
    required String label,
    required T value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: items.map((item) {
        return DropdownMenuItem<T>(value: item, child: Text(item.toString()));
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.number,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dose Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Syringe Details'),
            _dropdownField<String>(
              label: 'Type',
              value: _selectedSyringeType,
              items: const ['U-100', 'U-40'],
              onChanged: (val) {
                setState(() {
                  _selectedSyringeType = val!;
                  _updateDefaultTickMarks();
                });
              },
            ),
            _dropdownField<String>(
              label: 'Units',
              value: _selectedUnits,
              items: const ['100', '50', '30'],
              onChanged: (val) {
                setState(() => _selectedUnits = val!);
              },
            ),
            _textField(label: 'Tick marks', controller: _tickMarksController),

            _sectionTitle('Vial Details'),
            _textField(label: 'Water (mL)', controller: _waterController),
            _textField(label: 'Peptide (mg)', controller: _peptideMgController),

            _sectionTitle('Desired Dose'),
            _textField(
              label: 'Peptide (mcg)',
              controller: _desiredMcgController,
            ),

            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: implement actual calculation logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Calculation logic coming soon!'),
                    ),
                  );
                },
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate Dose'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
