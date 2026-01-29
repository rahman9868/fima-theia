import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        final summary = controller.summary.value;

        if (controller.isLoading.value && summary == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(controller.errorMessage.value),
          );
        }

        final workingDays = summary?.workingDays ?? 0;
        final onTime = summary?.onTime ?? 0;
        final late = summary?.late ?? 0;
        final absent = summary?.absent ?? 0;
        final businessTrip = summary?.businessTrip ?? 0;
        final leave = summary?.leave ?? 0;
        final pending = summary?.pending ?? 0;

        final DateTime? lastUpdatedAt = controller.lastUpdatedAt.value;
        final String lastUpdate = lastUpdatedAt != null
            ? DateFormat('yyyy-MM-dd, HH:mm:ss').format(lastUpdatedAt)
            : '-';

        return RefreshIndicator(
          onRefresh: controller.refreshSummary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Last Update : $lastUpdate',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please Pull to Refresh',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      child: Column(
                        children: [
                          _DashboardItem(
                            color: Colors.blue,
                            label: 'Working Days',
                            value: workingDays.toString(),
                          ),
                          const SizedBox(height: 12),
                          _DashboardItem(
                            color: Colors.green,
                            label: 'On-Time',
                            value: onTime.toString(),
                          ),
                          const SizedBox(height: 12),
                          _DashboardItem(
                            color: Colors.orange,
                            label: 'Late',
                            value: late.toString(),
                          ),
                          const SizedBox(height: 12),
                          _DashboardItem(
                            color: Colors.red,
                            label: 'Absent',
                            value: absent.toString(),
                          ),
                          const SizedBox(height: 12),
                          _DashboardItem(
                            color: Colors.indigo,
                            label: 'Business Trip',
                            value: businessTrip.toString(),
                          ),
                          const SizedBox(height: 12),
                          _DashboardItem(
                            color: Colors.purple,
                            label: 'Leave',
                            value: leave.toString(),
                          ),
                          const SizedBox(height: 12),
                          _DashboardItem(
                            color: Colors.deepOrange,
                            label: 'Pending',
                            value: pending.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _DashboardItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const _DashboardItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.bookmark,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF1565C0),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          ':',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 48,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
  }
