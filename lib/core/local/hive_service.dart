import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/auth/domain/entity/user.dart';
import '../../features/acl/domain/entity/employee_dto.dart';

class HiveService {
  static const String userBoxName = 'userBox';
  static const String dashboardSummaryBoxName = 'dashboardSummaryBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(EmployeeDtoAdapter());
    Hive.registerAdapter(AccountDtoAdapter());
    Hive.registerAdapter(RoleDtoAdapter());
    Hive.registerAdapter(AccessDtoAdapter());
    Hive.registerAdapter(AssignmentDtoAdapter());
    Hive.registerAdapter(OrganizationDtoAdapter());
    Hive.registerAdapter(LocationDtoAdapter());
    Hive.registerAdapter(OrganizationConfigDtoAdapter());
    Hive.registerAdapter(WorkingScheduleDtoAdapter());
    Hive.registerAdapter(LocationDetailDtoAdapter());
    Hive.registerAdapter(JobDtoAdapter());
    Hive.registerAdapter(CompanyDtoAdapter());
    Hive.registerAdapter(JobGroupDtoAdapter());
    Hive.registerAdapter(EmployeeSupervisorDtoAdapter());
    await Hive.openBox<User>(userBoxName);
    await Hive.openBox<Map>(dashboardSummaryBoxName);
  }

  static Future<void> saveUser(User user) async {
    final box = Hive.box<User>(userBoxName);
    await box.put('user', user);
  }

  static User? getUser() {
    final box = Hive.box<User>(userBoxName);
    return box.get('user');
  }

  static Future<void> deleteUser() async {
    final box = Hive.box<User>(userBoxName);
    await box.delete('user');
  }

  static Future<void> saveDashboardSummary(Map<String, dynamic> data) async {
    final box = Hive.box<Map>(dashboardSummaryBoxName);
    await box.put('summary', data);
  }

  static Map<String, dynamic>? getDashboardSummary() {
    if (!Hive.isBoxOpen(dashboardSummaryBoxName)) {
      return null;
    }
    final box = Hive.box<Map>(dashboardSummaryBoxName);
    final raw = box.get('summary');
    if (raw == null) return null;
    return Map<String, dynamic>.from(raw);
  }

  static Future<void> clearDashboardSummary() async {
    if (!Hive.isBoxOpen(dashboardSummaryBoxName)) {
      return;
    }
    final box = Hive.box<Map>(dashboardSummaryBoxName);
    await box.delete('summary');
  }
}
