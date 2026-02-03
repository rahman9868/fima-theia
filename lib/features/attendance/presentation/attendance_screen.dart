import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.attendanceRecords.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 60,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchAttendanceRecords,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchAttendanceRecords,
          child: Column(
            children: [
              // Attendance Summary Card
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Attendance',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                controller.attendanceRecords.isNotEmpty &&
                                        controller.attendanceRecords.first.checkInTime != null
                                    ? controller.attendanceRecords.first.checkOutTime != null
                                        ? 'Checked Out'
                                        : 'Checked In'
                                    : 'Not Checked In',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: controller.attendanceRecords.isNotEmpty &&
                                              controller.attendanceRecords.first.checkInTime != null
                                          ? controller.attendanceRecords.first.checkOutTime != null
                                              ? Colors.green
                                              : Colors.blue
                                          : Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: controller.attendanceRecords.isEmpty ||
                                    controller.attendanceRecords.first.checkOutTime != null
                                ? controller.checkIn
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.login),
                                SizedBox(width: 8),
                                Text('Check In'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Recent Attendance Records
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.attendanceRecords.length,
                  itemBuilder: (context, index) {
                    final record = controller.attendanceRecords[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(
                          record.checkInTime != null ? Icons.check_circle : Icons.pending,
                          color: record.checkInTime != null ? Colors.green : Colors.grey,
                        ),
                        title: Text(
                          '${record.date.day}/${record.date.month}/${record.date.year}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (record.checkInTime != null)
                              Text(
                                'In: ${record.checkInTime?.hour.toString().padLeft(2, '0')}:${record.checkInTime?.minute.toString().padLeft(2, '0')}',
                              ),
                            if (record.checkOutTime != null)
                              Text(
                                'Out: ${record.checkOutTime?.hour.toString().padLeft(2, '0')}:${record.checkOutTime?.minute.toString().padLeft(2, '0')}',
                              ),
                            if (record.status != null)
                              Text('Status: ${record.status}'),
                          ],
                        ),
                        trailing: record.checkInTime != null && record.checkOutTime == null
                            ? ElevatedButton(
                                onPressed: () => controller.checkOut(record.employeeId),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Check Out'),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fetchAttendanceRecords,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}