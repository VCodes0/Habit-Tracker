import '../../core/utils/date_time_helper.dart';
import '../controllers/habit_controller.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/monthly_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../widgets/my_alert_box.dart';
import '../widgets/habit_tile.dart';
import '../widgets/my_fab.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HabitController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(
        onPressed: () => _showHabitDialog(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ResponsiveLayout(
        mobileLayout: _buildMobileLayout(context),
        webLayout: _buildWebLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Obx(() {
      return ListView(
        children: [
          if (controller.heatMapDataSet.isNotEmpty)
            MonthlySummary(
              datasets: controller.heatMapDataSet,
              startDate:
                  controller.startDate ?? DateTimeHelper.todaysDateFormatted(),
            ),
          const SizedBox(height: 20),
          _buildHeader(),
          const SizedBox(height: 10),
          _buildHabitList(),
          const SizedBox(height: 100),
        ],
      );
    });
  }

  Widget _buildWebLayout(BuildContext context) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Monthly Progress',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  if (controller.heatMapDataSet.isNotEmpty)
                    MonthlySummary(
                      datasets: controller.heatMapDataSet,
                      startDate:
                          controller.startDate ??
                          DateTimeHelper.todaysDateFormatted(),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  Expanded(child: _buildHabitList()),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Today\'s Habits',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(() {
              final completed = controller.todaysHabits
                  .where((h) => h.isCompleted)
                  .length;
              final total = controller.todaysHabits.length;
              return Text(
                '$completed/$total',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitList() {
    if (controller.todaysHabits.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: [
              Icon(Icons.sentiment_dissatisfied, size: 80, color: Colors.grey),
              SizedBox(height: 20),
              Text(
                'No habits yet.\nTap the + button to create one!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: kIsWeb ? null : const NeverScrollableScrollPhysics(),
      itemCount: controller.todaysHabits.length,
      itemBuilder: (context, index) {
        final habit = controller.todaysHabits[index];
        return HabitTile(
          habit: habit,
          onChanged: (value) => controller.toggleHabit(index, value),
          settingsTapped: (context) => _showHabitDialog(context, index: index),
          deleteTapped: (context) => _confirmDelete(context, index),
        );
      },
    );
  }

  void _showHabitDialog(BuildContext context, {int? index}) {
    final TextEditingController textController = TextEditingController();
    if (index != null) {
      textController.text = controller.todaysHabits[index].name;
    }

    Get.dialog(
      MyAlertBox(
        controller: textController,
        hintText: index == null ? 'Enter habit name...' : 'Edit habit name...',
        onSave: () {
          if (index == null) {
            controller.createNewHabit(textController.text);
          } else {
            controller.updateHabit(index, textController.text);
          }
          Get.back();
        },
        onCancel: () => Get.back(),
      ),
    );
  }

  void _confirmDelete(BuildContext context, int index) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Delete Habit',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete this habit?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              controller.deleteHabit(index);
              Get.back();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
