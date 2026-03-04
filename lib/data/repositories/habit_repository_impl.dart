import '../datasources/local/habit_local_datasource.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../core/utils/date_time_helper.dart';
import '../models/daily_summary.dart';
import '../models/habit.dart';
import 'package:get/get.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource localDataSource;

  final _todaysHabits = <Habit>[].obs;
  final _heatMapDataSet = <DateTime, int>{}.obs;
  final _startDate = ''.obs;

  @override
  List<Habit> get todaysHabits => _todaysHabits;

  @override
  Map<DateTime, int> get heatMapDataSet => _heatMapDataSet;

  HabitRepositoryImpl({required this.localDataSource});

  @override
  Future<void> initialize() async {
    await localDataSource.init();

    String? loadedStartDate = localDataSource.getStartDate();
    if (loadedStartDate == null ||
        !DateTimeHelper.isValidDateString(loadedStartDate)) {
      loadedStartDate = DateTimeHelper.todaysDateFormatted();
      localDataSource.setStartDate(loadedStartDate);
    }
    _startDate.value = loadedStartDate;

    if (localDataSource.hasCurrentHabitList() == null) {
      createDefaultData();
    } else {
      _todaysHabits.value = localDataSource.getAllHabits();
    }

    loadHeatMap();
  }

  @override
  void createDefaultData() {
    final now = DateTime.now();
    _todaysHabits.value = [
      Habit(
        name: "Welcome To HabitTracker !",
        isCompleted: true,
        createdAt: now,
      ),
    ];

    final todayStr = DateTimeHelper.todaysDateFormatted();
    localDataSource.setStartDate(todayStr);
    _startDate.value = todayStr;
    localDataSource.setCurrentHabitListFlag();
    _saveToHive();
  }

  @override
  Future<void> addHabit(Habit habit) async {
    _todaysHabits.add(habit);
    await _saveToHive();
  }

  @override
  Future<void> updateHabit(int index, Habit habit) async {
    _todaysHabits[index] = habit;
    await _saveToHive();
  }

  @override
  Future<void> deleteHabit(int index) async {
    _todaysHabits.removeAt(index);
    await _saveToHive();
  }

  @override
  Future<void> toggleHabit(int index, bool isCompleted) async {
    final old = _todaysHabits[index];
    _todaysHabits[index] = Habit(
      name: old.name,
      isCompleted: isCompleted,
      createdAt: old.createdAt,
      id: old.id,
    );
    await _saveToHive();
  }

  Future<void> _saveToHive() async {
    await localDataSource.saveHabits(_todaysHabits);

    int completedCount = _todaysHabits.where((h) => h.isCompleted).length;
    double percentage = _todaysHabits.isEmpty
        ? 0.0
        : completedCount / _todaysHabits.length;

    final summary = DailySummary(
      date: DateTimeHelper.todaysDateFormatted(),
      completionPercentage: percentage,
      totalHabits: _todaysHabits.length,
      completedHabits: completedCount,
    );
    await localDataSource.saveDailySummary(summary);

    loadHeatMap();
  }

  @override
  void loadHeatMap() {
    String startDateStr =
        localDataSource.getStartDate() ?? DateTimeHelper.todaysDateFormatted();
    DateTime startDate = DateTimeHelper.createDateTimeObject(startDateStr);

    int daysInBetween = DateTime.now().difference(startDate).inDays;

    final newHeatMap = <DateTime, int>{};

    for (int i = 0; i <= daysInBetween; i++) {
      DateTime date = startDate.add(Duration(days: i));
      String yyyymmdd = DateTimeHelper.convertDateTimeToString(date);

      var summary = localDataSource.getDailySummary(yyyymmdd);
      double percentage = summary?.completionPercentage ?? 0.0;

      newHeatMap[DateTime(date.year, date.month, date.day)] = (10 * percentage)
          .toInt();
    }

    _heatMapDataSet.value = newHeatMap;
  }
}
