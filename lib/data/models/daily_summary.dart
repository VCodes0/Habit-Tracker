import 'package:hive/hive.dart';
part 'daily_summary.g.dart';

@HiveType(typeId: 1)
class DailySummary {
  @HiveField(0)
  final String date;

  @HiveField(1)
  final double completionPercentage;

  @HiveField(2)
  final int totalHabits;

  @HiveField(3)
  final int completedHabits;

  DailySummary({
    required this.date,
    required this.completionPercentage,
    required this.totalHabits,
    required this.completedHabits,
  });
}
