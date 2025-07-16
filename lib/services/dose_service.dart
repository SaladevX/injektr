import 'package:hive/hive.dart';
import '../models/dose_entry.dart';

class DoseService {
  static const String boxName = 'dose_entries';

  Future<void> init() async {
    Hive.registerAdapter(DoseEntryAdapter());
    await Hive.openBox<DoseEntry>(boxName);
  }

  Box<DoseEntry> get _box => Hive.box<DoseEntry>(boxName);

  List<DoseEntry> getAll() => _box.values.toList();

  Future<void> addEntry(DoseEntry entry) async {
    await _box.add(entry);
  }

  Future<void> deleteEntry(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> updateEntry(int index, DoseEntry updated) async {
    await _box.putAt(index, updated);
  }
}
