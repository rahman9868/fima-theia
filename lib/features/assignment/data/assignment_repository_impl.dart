import 'package:hive/hive.dart';
import '../../../../core/local/hive_service.dart';
import '../domain/entity/assignment.dart';
import '../domain/entity/schedule.dart';
import '../domain/repository/assignment_repository.dart';
import 'assignment_remote_data_source.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDataSource _remoteDataSource;

  AssignmentRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Assignment>> getAssignmentsBySchedule() async {
    return await _remoteDataSource.getAssignmentsBySchedule();
  }

  @override
  Future<List<Schedule>> getScheduleEmployee() async {
    return await _remoteDataSource.getScheduleEmployee();
  }

  @override
  Future<List<FlexibleSchedule>> getFlexibleScheduleEmployee() async {
    return await _remoteDataSource.getFlexibleScheduleEmployee();
  }

  @override
  Future<List<FlexibleTempSchedule>> getFlexibleTempScheduleEmployee() async {
    return await _remoteDataSource.getFlexibleTempScheduleEmployee();
  }

  @override
  Future<void> saveAssignments(List<Assignment> assignments) async {
    final box = await Hive.openBox<Assignment>('assignmentBox');
    await box.putAll({for (var i = 0; i < assignments.length; i++) i: assignments[i]});
  }

  @override
  List<Assignment>? getSavedAssignments() {
    if (!Hive.isBoxOpen('assignmentBox')) {
      return null;
    }
    final box = Hive.box<Assignment>('assignmentBox');
    return box.values.toList();
  }

  @override
  Future<void> clearAssignments() async {
    if (!Hive.isBoxOpen('assignmentBox')) {
      return;
    }
    final box = Hive.box<Assignment>('assignmentBox');
    await box.clear();
  }

  @override
  Assignment? getTodayAssignment() {
    final assignments = getSavedAssignments();
    if (assignments == null || assignments.isEmpty) {
      return null;
    }

    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    // Find assignment for today based on workingDayCode
    for (var assignment in assignments) {
      if (assignment.workingDayCode == todayStr) {
        return assignment;
      }
    }

    return null;
  }

  @override
  Future<void> saveSchedules(List<Schedule> schedules) async {
    await HiveService.saveSchedule(schedules);
  }

  @override
  List<Schedule>? getSavedSchedules() {
    return HiveService.getSchedules();
  }

  @override
  Future<void> clearSchedules() async {
    await HiveService.clearSchedules();
  }

  @override
  Future<void> saveFlexibleSchedules(List<FlexibleSchedule> schedules) async {
    await HiveService.saveFlexibleSchedule(schedules);
  }

  @override
  List<FlexibleSchedule>? getSavedFlexibleSchedules() {
    return HiveService.getFlexibleSchedules();
  }

  @override
  Future<void> clearFlexibleSchedules() async {
    await HiveService.clearFlexibleSchedules();
  }

  @override
  Future<void> saveFlexibleTempSchedules(
      List<FlexibleTempSchedule> schedules) async {
    await HiveService.saveFlexibleTempSchedule(schedules);
  }

  @override
  List<FlexibleTempSchedule>? getSavedFlexibleTempSchedules() {
    return HiveService.getFlexibleTempSchedules();
  }

  @override
  Future<void> clearFlexibleTempSchedules() async {
    await HiveService.clearFlexibleTempSchedules();
  }
}