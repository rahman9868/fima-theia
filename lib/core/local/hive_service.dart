import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/auth/domain/entity/user.dart';
import '../../features/acl/domain/entity/employee_dto.dart';
import '../../features/assignment/domain/entity/assignment.dart';
import '../../features/assignment/domain/entity/schedule.dart';

class HiveService {
  static const String userBoxName = 'userBox';
  static const String dashboardSummaryBoxName = 'dashboardSummaryBox';
  static const String assignmentBoxName = 'assignmentBox';
  static const String scheduleBoxName = 'scheduleBox';
  static const String flexibleScheduleBoxName = 'flexibleScheduleBox';
  static const String flexibleTempScheduleBoxName = 'flexibleTempScheduleBox';

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
    Hive.registerAdapter(AssignmentAdapter());
    Hive.registerAdapter(ScheduleAdapter());
    Hive.registerAdapter(FlexibleScheduleAdapter());
    Hive.registerAdapter(FlexibleTempScheduleAdapter());
    await Hive.openBox<User>(userBoxName);
    await Hive.openBox<Map>(dashboardSummaryBoxName);
    await Hive.openBox<Assignment>(assignmentBoxName);
    await Hive.openBox<Schedule>(scheduleBoxName);
    await Hive.openBox<FlexibleSchedule>(flexibleScheduleBoxName);
    await Hive.openBox<FlexibleTempSchedule>(flexibleTempScheduleBoxName);
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

  static Future<void> saveSchedule(List<Schedule> schedules) async {
    final box = Hive.box<Schedule>(scheduleBoxName);
    await box.clear();
    await box.putAll({for (var i = 0; i < schedules.length; i++) i: schedules[i]});
  }

  static List<Schedule>? getSchedules() {
    if (!Hive.isBoxOpen(scheduleBoxName)) {
      return null;
    }
    final box = Hive.box<Schedule>(scheduleBoxName);
    return box.values.toList();
  }

  static Future<void> clearSchedules() async {
    if (!Hive.isBoxOpen(scheduleBoxName)) {
      return;
    }
    final box = Hive.box<Schedule>(scheduleBoxName);
    await box.clear();
  }

  static Future<void> saveFlexibleSchedule(List<FlexibleSchedule> schedules) async {
    final box = Hive.box<FlexibleSchedule>(flexibleScheduleBoxName);
    await box.clear();
    await box.putAll({for (var i = 0; i < schedules.length; i++) i: schedules[i]});
  }

  static List<FlexibleSchedule>? getFlexibleSchedules() {
    if (!Hive.isBoxOpen(flexibleScheduleBoxName)) {
      return null;
    }
    final box = Hive.box<FlexibleSchedule>(flexibleScheduleBoxName);
    return box.values.toList();
  }

  static Future<void> clearFlexibleSchedules() async {
    if (!Hive.isBoxOpen(flexibleScheduleBoxName)) {
      return;
    }
    final box = Hive.box<FlexibleSchedule>(flexibleScheduleBoxName);
    await box.clear();
  }

  static Future<void> saveFlexibleTempSchedule(List<FlexibleTempSchedule> schedules) async {
    final box = Hive.box<FlexibleTempSchedule>(flexibleTempScheduleBoxName);
    await box.clear();
    await box.putAll({for (var i = 0; i < schedules.length; i++) i: schedules[i]});
  }

  static List<FlexibleTempSchedule>? getFlexibleTempSchedules() {
    if (!Hive.isBoxOpen(flexibleTempScheduleBoxName)) {
      return null;
    }
    final box = Hive.box<FlexibleTempSchedule>(flexibleTempScheduleBoxName);
    return box.values.toList();
  }

  static Future<void> clearFlexibleTempSchedules() async {
    if (!Hive.isBoxOpen(flexibleTempScheduleBoxName)) {
      return;
    }
    final box = Hive.box<FlexibleTempSchedule>(flexibleTempScheduleBoxName);
    await box.clear();
  }
}
