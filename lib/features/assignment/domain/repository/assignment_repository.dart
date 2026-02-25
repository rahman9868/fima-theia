import '../entity/assignment.dart';
import '../entity/schedule.dart';

abstract class AssignmentRepository {
  Future<List<Assignment>> getAssignmentsBySchedule();
  Future<List<Schedule>> getScheduleEmployee();
  Future<List<FlexibleSchedule>> getFlexibleScheduleEmployee();
  Future<List<FlexibleTempSchedule>> getFlexibleTempScheduleEmployee();
  Future<void> saveAssignments(List<Assignment> assignments);
  List<Assignment>? getSavedAssignments();
  Future<void> clearAssignments();
  Assignment? getTodayAssignment();
  
  // Schedule storage methods
  Future<void> saveSchedules(List<Schedule> schedules);
  List<Schedule>? getSavedSchedules();
  Future<void> clearSchedules();
  
  // Flexible schedule storage methods
  Future<void> saveFlexibleSchedules(List<FlexibleSchedule> schedules);
  List<FlexibleSchedule>? getSavedFlexibleSchedules();
  Future<void> clearFlexibleSchedules();
  
  // Flexible temp schedule storage methods
  Future<void> saveFlexibleTempSchedules(List<FlexibleTempSchedule> schedules);
  List<FlexibleTempSchedule>? getSavedFlexibleTempSchedules();
  Future<void> clearFlexibleTempSchedules();
}