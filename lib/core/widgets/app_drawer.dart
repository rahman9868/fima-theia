import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  bool _isCurrentRoute(String location, String route) {
    if (location == route) return true;
    return location.startsWith('$route/');
  }

  void _onMenuTap(BuildContext context, String targetRoute) {
    final String currentPath = GoRouterState.of(context).uri.path;
    Navigator.of(context).pop();
    if (_isCurrentRoute(currentPath, targetRoute)) {
      return;
    }
    context.go(targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
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
              selected: _isCurrentRoute(location, AppRoutes.dashboard),
              onTap: () => _onMenuTap(context, AppRoutes.dashboard),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              selected: _isCurrentRoute(location, AppRoutes.about),
              onTap: () => _onMenuTap(context, AppRoutes.about),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Work Calendar'),
              selected: _isCurrentRoute(location, AppRoutes.workCalendar),
              onTap: () => _onMenuTap(context, AppRoutes.workCalendar),
            ),
            ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: const Text('Attendance'),
              selected: _isCurrentRoute(location, AppRoutes.attendance),
              onTap: () => _onMenuTap(context, AppRoutes.attendance),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                Navigator.of(context).pop();
                final authController = Get.find<AuthController>();
                await authController.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
