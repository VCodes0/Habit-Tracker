import 'package:hive/hive.dart';
part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final bool isCompleted;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final String? id;

  Habit({
    required this.name,
    required this.isCompleted,
    required this.createdAt,
    this.id,
  });
}
