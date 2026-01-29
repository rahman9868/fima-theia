import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                context.go('/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                context.go('/about');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                context.go('/');
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(controller.errorMessage.value),
          );
        }

        final summary = controller.attendanceSummary.value;
        if (summary == null || summary.data == null || summary.data!.isEmpty) {
          return const Center(
            child: Text('No attendance data'),
          );
        }

        final data = summary.data!.first;
        final events = data.event ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Attendance for ${data.month}/${data.year} (Employee ${data.employeeId})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final e = events[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(e.day.toString()),
                    ),
                    title: Text('Day ${e.day}'),
                    subtitle: Text('Event: ${e.eventType}'),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
