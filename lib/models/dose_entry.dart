import 'package:hive/hive.dart';

part 'dose_entry.g.dart';

@HiveType(typeId: 0)
class DoseEntry extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double doseMg;

  @HiveField(2)
  String injectionSite;

  @HiveField(3)
  double weight;

  @HiveField(4)
  List<String> sideEffects;

  @HiveField(5)
  String notes;

  @HiveField(6)
  bool hasISR;

  DoseEntry({
    required this.date,
    required this.doseMg,
    required this.injectionSite,
    required this.weight,
    required this.sideEffects,
    required this.notes,
    required this.hasISR,
  });
}
