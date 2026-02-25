import 'package:get/get.dart';
import '../domain/entity/assignment.dart';
import '../domain/entity/schedule.dart';
import '../domain/usecase/get_assignments_usecase.dart';
import '../data/assignment_repository_impl.dart';
import '../data/assignment_remote_data_source.dart';
import '../../../../core/network/api_client.dart';

enum AssignmentType { schedule, flexi, flexiTemp }

class AssignmentController extends GetxController {
  late final GetAssignmentsUseCase _getAssignmentsUseCase;
  late final GetScheduleUseCase _getScheduleUseCase;
  late final GetFlexibleScheduleUseCase _getFlexibleScheduleUseCase;
  late final GetFlexibleTempScheduleUseCase _getFlexibleTempScheduleUseCase;

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var todayAssignment = Rx<Assignment?>(null);
  var todaySchedule = Rx<dynamic>(null);

  @override
  void onInit() {
    super.onInit();
    final repository = AssignmentRepositoryImpl(
      AssignmentRemoteDataSource(ApiClient()),
    );
    _getAssignmentsUseCase = GetAssignmentsUseCase(repository);
    _getScheduleUseCase = GetScheduleUseCase(repository);
    _getFlexibleScheduleUseCase = GetFlexibleScheduleUseCase(repository);
    _getFlexibleTempScheduleUseCase = GetFlexibleTempScheduleUseCase(repository);
  }

  AssignmentType getAssignmentType(Assignment assignment) {
    // Based on attendanceType, determine the assignment type
    // 0 = Schedule, 1 = Flexi, 2 = FlexiTemp (adjust based on actual API values)
    switch (assignment.attendanceType) {
      case 0:
        return AssignmentType.schedule;
      case 1:
        return AssignmentType.flexi;
      case 2:
        return AssignmentType.flexiTemp;
      default:
        // Try to determine from attendanceTypeStr
        final typeStr = assignment.attendanceTypeStr.toLowerCase();
        if (typeStr.contains('flexitemp') || typeStr.contains('flexi_temp')) {
          return AssignmentType.flexiTemp;
        } else if (typeStr.contains('flexi')) {
          return AssignmentType.flexi;
        } else {
          return AssignmentType.schedule;
        }
    }
  }

  Future<void> loadTodayAssignment() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final assignment = _getAssignmentsUseCase.getTodayAssignment();
      todayAssignment.value = assignment;
      if (assignment != null) {
        await loadTodaySchedule(assignment);
      }
    } catch (e) {
      errorMessage.value = 'Failed to load assignment: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadTodaySchedule(Assignment assignment) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final type = getAssignmentType(assignment);
      
      switch (type) {
        case AssignmentType.schedule:
          final schedules = await _getScheduleUseCase();
          await _getScheduleUseCase.saveSchedules(schedules);
          todaySchedule.value = schedules;
          break;
        case AssignmentType.flexi:
          final schedules = await _getFlexibleScheduleUseCase();
          await _getFlexibleScheduleUseCase.saveSchedules(schedules);
          todaySchedule.value = schedules;
          break;
        case AssignmentType.flexiTemp:
          final schedules = await _getFlexibleTempScheduleUseCase();
          await _getFlexibleTempScheduleUseCase.saveSchedules(schedules);
          todaySchedule.value = schedules;
          break;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load schedule: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshAssignments() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final assignments = await _getAssignmentsUseCase();
      await _getAssignmentsUseCase.saveAssignments(assignments);
      await loadTodayAssignment();
    } catch (e) {
      errorMessage.value = 'Failed to refresh assignments: $e';
    } finally {
      isLoading.value = false;
    }
  }

  List<Assignment>? getAllAssignments() {
    return _getAssignmentsUseCase.getSavedAssignments();
  }

  List<Schedule>? getSavedSchedules() {
    return _getScheduleUseCase.getSavedSchedules();
  }

  List<FlexibleSchedule>? getSavedFlexibleSchedules() {
    return _getFlexibleScheduleUseCase.getSavedSchedules();
  }

  List<FlexibleTempSchedule>? getSavedFlexibleTempSchedules() {
    return _getFlexibleTempScheduleUseCase.getSavedSchedules();
  }
}