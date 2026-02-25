import '../entity/assignment.dart';
import '../entity/schedule.dart';
import '../repository/assignment_repository.dart';

class GetAssignmentsUseCase {
  final AssignmentRepository _repository;

  GetAssignmentsUseCase(this._repository);

  Future<List<Assignment>> call() async {
    return await _repository.getAssignmentsBySchedule();
  }

  Future<void> saveAssignments(List<Assignment> assignments) async {
    await _repository.saveAssignments(assignments);
  }

  List<Assignment>? getSavedAssignments() {
    return _repository.getSavedAssignments();
  }

  Future<void> clearAssignments() async {
    await _repository.clearAssignments();
  }

  Assignment? getTodayAssignment() {
    return _repository.getTodayAssignment();
  }
}

class GetScheduleUseCase {
  final AssignmentRepository _repository;

  GetScheduleUseCase(this._repository);

  Future<List<Schedule>> call() async {
    return await _repository.getScheduleEmployee();
  }

  Future<void> saveSchedules(List<Schedule> schedules) async {
    await _repository.saveSchedules(schedules);
  }

  List<Schedule>? getSavedSchedules() {
    return _repository.getSavedSchedules();
  }

  Future<void> clearSchedules() async {
    await _repository.clearSchedules();
  }
}

class GetFlexibleScheduleUseCase {
  final AssignmentRepository _repository;

  GetFlexibleScheduleUseCase(this._repository);

  Future<List<FlexibleSchedule>> call() async {
    return await _repository.getFlexibleScheduleEmployee();
  }

  Future<void> saveSchedules(List<FlexibleSchedule> schedules) async {
    await _repository.saveFlexibleSchedules(schedules);
  }

  List<FlexibleSchedule>? getSavedSchedules() {
    return _repository.getSavedFlexibleSchedules();
  }

  Future<void> clearSchedules() async {
    await _repository.clearFlexibleSchedules();
  }
}

class GetFlexibleTempScheduleUseCase {
  final AssignmentRepository _repository;

  GetFlexibleTempScheduleUseCase(this._repository);

  Future<List<FlexibleTempSchedule>> call() async {
    return await _repository.getFlexibleTempScheduleEmployee();
  }

  Future<void> saveSchedules(List<FlexibleTempSchedule> schedules) async {
    await _repository.saveFlexibleTempSchedules(schedules);
  }

  List<FlexibleTempSchedule>? getSavedSchedules() {
    return _repository.getSavedFlexibleTempSchedules();
  }

  Future<void> clearSchedules() async {
    await _repository.clearFlexibleTempSchedules();
  }
}