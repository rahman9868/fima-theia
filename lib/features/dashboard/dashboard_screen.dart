import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/app_drawer.dart';
import 'presentation/controller/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const AppDrawer(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(controller.errorMessage.value),
          );
        }

        final summary = controller.summary.value;
        if (summary == null) {
          return const Center(
            child: Text('No attendance data'),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Working days: ${summary.workingDays}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('On time: ${summary.onTime}'),
              Text('Late: ${summary.late}'),
              Text('Absent: ${summary.absent}'),
              Text('Business trip: ${summary.businessTrip}'),
              Text('Leave: ${summary.leave}'),
              Text('Pending: ${summary.pending}'),
              const SizedBox(height: 12),
              Text('Last update: ${summary.lastUpdate}'),
            ],
          ),
        );
      }),
    );
  }
}
