import '../../domain/repositories/habit_repository.dart';
import '../../data/models/habit.dart';
import 'package:get/get.dart';

class HabitController extends GetxController {
  final HabitRepository repository;

  HabitController({required this.repository});

  List<Habit> get todaysHabits => repository.todaysHabits;
  Map<DateTime, int> get heatMapDataSet => repository.heatMapDataSet;

  String? get startDate {
    if (todaysHabits.isEmpty) return null;
    final earliest = todaysHabits
        .map((h) => h.createdAt)
        .reduce((a, b) => a.isBefore(b) ? a : b);
    return earliest.toIso8601String().split('T')[0];
  }

  @override
  void onInit() {
    super.onInit();
    repository.initialize();
  }

  void toggleHabit(int index, bool? value) {
    if (value != null) {
      repository.toggleHabit(index, value);
    }
  }

  void createNewHabit(String name) {
    if (name.trim().isNotEmpty) {
      final habit = Habit(
        name: name.trim(),
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      repository.addHabit(habit);
    }
  }

  void updateHabit(int index, String newName) {
    if (newName.trim().isNotEmpty) {
      final old = todaysHabits[index];
      final updated = Habit(
        name: newName.trim(),
        isCompleted: old.isCompleted,
        createdAt: old.createdAt,
        id: old.id,
      );
      repository.updateHabit(index, updated);
    }
  }

  void deleteHabit(int index) {
    repository.deleteHabit(index);
  }
}
