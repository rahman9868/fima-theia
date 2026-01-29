import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entity/attendance_summary_dto.dart';
import '../../domain/entity/attendance_summary.dart';
import '../../domain/usecase/get_attendance_summary_usecase.dart';
import '../../data/attendance_summary_repository_impl.dart';
import '../../../../core/local/hive_service.dart';

class DashboardController extends GetxController {
  final GetAttendanceSummaryUseCase _getAttendanceSummaryUseCase =
      GetAttendanceSummaryUseCase(AttendanceSummaryRepositoryImpl());

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final Rx<AttendanceSummary?> summary = Rx<AttendanceSummary?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadAttendanceSummary();
  }

  Future<void> _loadAttendanceSummary() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final user = HiveService.getUser();
      final employeeId = user?.employeeDto?.id;

      if (employeeId == null) {
        errorMessage.value = 'Employee ID not found';
        isLoading.value = false;
        return;
      }

      final now = DateTime.now();
      debugPrint('[DashboardController] Fetching attendance summary for employeeId=$employeeId, year=${now.year}, month=${now.month}');

      final result = await _getAttendanceSummaryUseCase.execute(
        employeeId: employeeId,
        year: now.year,
        month: now.month,
      );

      if (result == null || result.data == null || result.data!.isEmpty) {
        errorMessage.value = 'No attendance data found';
        return;
      }

      final data = result.data!.first;
      final events = data.event ?? <AttendanceSummaryDto>[];

      _processAttendanceSummary(
        events: events,
        year: data.year,
        month: data.month,
      );
    } catch (e, stack) {
      errorMessage.value = 'Failed to load attendance summary';
      debugPrint('[DashboardController] Error loading attendance summary: $e');
      debugPrint(stack.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _processAttendanceSummary({
    required List<AttendanceSummaryDto> events,
    required int year,
    required int month,
  }) {
    if (events.isEmpty) {
      debugPrint('[DashboardController] No events to process');
      summary.value = const AttendanceSummary(
        workingDays: 0,
        onTime: 0,
        late: 0,
        absent: 0,
        businessTrip: 0,
        leave: 0,
        pending: 0,
        lastUpdate: '',
      );
      return;
    }

    final today = DateTime.now();
    final todayDay = today.day;

    int onTime = 0;
    int late = 0;
    int absent = 0;
    int businessTrip = 0;
    int leave = 0;
    int pending = 0;
    int workingDays = 0;

    try {
      for (final e in events) {
        final type = e.eventType.toLowerCase();

        if (type == AttendanceEventType.onTime.value.toLowerCase()) {
          onTime++;
          workingDays++;
        } else if (type == AttendanceEventType.late.value.toLowerCase()) {
          late++;
          workingDays++;
        } else if (type == AttendanceEventType.absent.value.toLowerCase()) {
          absent++;
          workingDays++;
        } else if (type == AttendanceEventType.pending.value.toLowerCase()) {
          pending++;
          workingDays++;
        } else if (type == AttendanceEventType.business.value.toLowerCase()) {
          businessTrip++;
          if (e.day <= todayDay) {
            workingDays++;
          }
        } else if (type == AttendanceEventType.leave.value.toLowerCase()) {
          leave++;
          if (e.day <= todayDay) {
            workingDays++;
          }
        }
      }

      final lastEvent = events.last;
      final lastDate = DateTime(year, month, lastEvent.day);
      final formattedLastUpdate = DateFormat('dd MMM yyyy').format(lastDate);

      debugPrint('[DashboardController] Summary computed: '
          'workingDays=$workingDays, onTime=$onTime, late=$late, absent=$absent, '
          'businessTrip=$businessTrip, leave=$leave, pending=$pending, '
          'lastUpdate=$formattedLastUpdate');

      summary.value = AttendanceSummary(
        workingDays: workingDays,
        onTime: onTime,
        late: late,
        absent: absent,
        businessTrip: businessTrip,
        leave: leave,
        pending: pending,
        lastUpdate: formattedLastUpdate,
      );
    } catch (e, stack) {
      errorMessage.value = 'Error processing attendance data';
      debugPrint('[DashboardController] Error processing attendance data: $e');
      debugPrint(stack.toString());
    }
  }
}
