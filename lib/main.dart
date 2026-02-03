import 'features/work_calendar/attendance_detail_page.dart';
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
import 'features/attendance/presentation/attendance_screen.dart';
import 'features/attendance/presentation/attendance_controller.dart';
import 'features/work_calendar/domain/usecase/get_attendance_detail_usecase.dart';
import 'features/work_calendar/presentation/attendance_detail_controller.dart';
import 'features/work_calendar/work_calendar_screen.dart';
import 'core/network/api_client.dart';
import 'features/work_calendar/data/attendance_remote_data_source.dart';
import 'features/work_calendar/data/attendance_repository_impl.dart';
import 'features/work_calendar/domain/usecase/get_work_calendar_usecase.dart';
import 'features/work_calendar/presentation/work_calendar_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

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
    GoRoute(
      path: AppRoutes.workCalendar,
      builder: (context, state) => const WorkCalendarScreen(),
    ),
    GoRoute(
      path: AppRoutes.workCalendarDetail,
      builder: (context, state) {
        final dateParam = state.pathParameters['date']!;
        final date = DateTime.parse(dateParam);
        return AttendanceDetailPage(date: date);
      },
    ),
    GoRoute(
      path: AppRoutes.attendance,
      builder: (context, state) => const AttendanceScreen(),
    ),
    ],
    );


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en_US', null);
  await Get.putAsync(() => TokenProvider().init());
  await HiveService.init();
  Get.put(AuthController());

  // Dependency injection for Work Calendar (clean architecture)
  final apiClient = Get.put(ApiClient());
  final remoteDataSource = Get.put(AttendanceRemoteDataSourceImpl(apiClient: apiClient));
  final attendanceRepository = Get.put(AttendanceRepositoryImpl(remoteDataSource: remoteDataSource));
  final workCalendarUsecase = Get.put(GetThreeMonthWorkCalendarUsecase(repository: attendanceRepository));
  Get.put(WorkCalendarController(getWorkCalendarUsecase: workCalendarUsecase));

  // Dependency injection for Attendance Detail
  final attendanceDetailUsecase = Get.put(GetAttendanceDetailUseCase(repository: attendanceRepository));
  Get.put(AttendanceDetailController(useCase: attendanceDetailUsecase));

  // Dependency injection for Attendance
  Get.put(AttendanceController());

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
