import '../../data/models/habit.dart';

abstract class HabitRepository {
  List<Habit> get todaysHabits;
  Map<DateTime, int> get heatMapDataSet;
  String? get startDate;

  Future<void> initialize();
  void createDefaultData();
  Future<void> addHabit(Habit habit);
  Future<void> updateHabit(int index, Habit habit);
  Future<void> deleteHabit(int index);
  Future<void> toggleHabit(int index, bool isCompleted);
  void loadHeatMap();
}
