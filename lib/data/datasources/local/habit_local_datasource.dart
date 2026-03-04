import 'package:hive_flutter/hive_flutter.dart';
import '../../models/daily_summary.dart';
import '../../models/habit.dart';

class HabitLocalDataSource {
  static const String habitBoxName = 'habits';
  static const String summaryBoxName = 'daily_summaries';
  static const String settingsBoxName = 'settings';

  late Box<Habit> habitBox;
  late Box<DailySummary> summaryBox;
  late Box settingsBox;

  Future<void> init() async {
    habitBox = await Hive.openBox<Habit>(habitBoxName);
    summaryBox = await Hive.openBox<DailySummary>(summaryBoxName);
    settingsBox = await Hive.openBox(settingsBoxName);
  }

  List<Habit> getAllHabits() => habitBox.values.toList();

  Future<void> saveHabits(List<Habit> habits) async {
    await habitBox.clear();
    for (var habit in habits) {
      await habitBox.add(habit);
    }
  }

  DailySummary? getDailySummary(String date) => summaryBox.get(date);

  Future<void> saveDailySummary(DailySummary summary) async {
    await summaryBox.put(summary.date, summary);
  }

  void setStartDate(String date) => settingsBox.put('START_DATE', date);

  String? getStartDate() => settingsBox.get('START_DATE');

  void setCurrentHabitListFlag() => settingsBox.put('CURRENT_HABIT_LIST', true);

  bool? hasCurrentHabitList() => settingsBox.get('CURRENT_HABIT_LIST');
}
