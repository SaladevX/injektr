class DoseHistory {
  final String type;
  final int units;
  final int tickMarks;
  final double waterMl;
  final double peptideMg;
  final double desiredMcg;
  final double resultTick;

  DoseHistory({
    required this.type,
    required this.units,
    required this.tickMarks,
    required this.waterMl,
    required this.peptideMg,
    required this.desiredMcg,
    required this.resultTick,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'units': units,
    'tickMarks': tickMarks,
    'waterMl': waterMl,
    'peptideMg': peptideMg,
    'desiredMcg': desiredMcg,
    'resultTick': resultTick,
  };

  factory DoseHistory.fromJson(Map<String, dynamic> json) => DoseHistory(
    type: json['type'],
    units: json['units'],
    tickMarks: json['tickMarks'],
    waterMl: json['waterMl'],
    peptideMg: json['peptideMg'],
    desiredMcg: json['desiredMcg'],
    resultTick: json['resultTick'],
  );
}
