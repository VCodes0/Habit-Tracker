import 'data/datasources/local/habit_local_datasource.dart';
import 'presentation/controllers/habit_controller.dart';
import 'data/repositories/habit_repository_impl.dart';
import 'domain/repositories/habit_repository.dart';
import 'package:hive_flutter/adapters.dart';
import 'presentation/pages/home_page.dart';
import 'data/models/daily_summary.dart';
import 'package:flutter/material.dart';
import 'data/models/habit.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(DailySummaryAdapter());

  final localDataSource = HabitLocalDataSource();
  await localDataSource.init();

  final repository = HabitRepositoryImpl(localDataSource: localDataSource);

  Get.put<HabitRepository>(repository);
  Get.put(HabitController(repository: repository));

  runApp(const HabitTracker());
}

class HabitTracker extends StatelessWidget {
  const HabitTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}
