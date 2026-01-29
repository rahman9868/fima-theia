import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'core/local/hive_service.dart';
import 'core/routes/app_routes.dart';
import 'core/services/token_provider.dart';
import 'features/auth/presentation/controller/auth_controller.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/dashboard/about_screen.dart';
import 'features/dashboard/dashboard_screen.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.about,
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => TokenProvider().init());
  await HiveService.init();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Clean Architecture Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF166DB2)),
        primaryColor: const Color(0xFF166DB2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF166DB2),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF166DB2),
          foregroundColor: Colors.white,
        ),
      ),
      routerConfig: _router,
    );
  }
}
