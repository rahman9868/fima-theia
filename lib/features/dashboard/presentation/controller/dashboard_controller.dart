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

  static const Duration _cacheValidity = Duration(minutes: 5);

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final Rx<AttendanceSummary?> summary = Rx<AttendanceSummary?>(null);
  final Rx<DateTime?> lastUpdatedAt = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    loadDashboardSummary();
  }

  Future<void> refreshSummary() async {
    await loadDashboardSummary(forceRefresh: true);
  }

  Future<void> loadDashboardSummary({bool forceRefresh = false}) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final cached = _readCachedSummary();
      final now = DateTime.now();

      if (!forceRefresh && cached != null) {
        debugPrint('[DashboardController] Using cached dashboard summary from local storage. lastUpdatedAt=${cached.lastUpdatedAt.toIso8601String()}');

        summary.value = cached.summary;
        lastUpdatedAt.value = cached.lastUpdatedAt;

        final isFresh = now.difference(cached.lastUpdatedAt) < _cacheValidity;
        if (isFresh) {
          debugPrint('[DashboardController] Cached dashboard summary is fresh. Skipping API call.');
          return;
        }

        debugPrint('[DashboardController] Cached dashboard summary is stale. Refreshing from API.');

        final fresh = await _fetchSummaryFromApi();
        if (fresh != null) {
          await _cacheSummary(fresh);
          final refreshed = _readCachedSummary();
          if (refreshed != null) {
            debugPrint('[DashboardController] Local dashboard summary updated after API refresh. lastUpdatedAt=${refreshed.lastUpdatedAt.toIso8601String()}');
            summary.value = refreshed.summary;
            lastUpdatedAt.value = refreshed.lastUpdatedAt;
          }
        }
        return;
      }

      debugPrint('[DashboardController] No valid cached dashboard summary. Fetching from API.');

      final fresh = await _fetchSummaryFromApi();
      if (fresh != null) {
        await _cacheSummary(fresh);
        final refreshed = _readCachedSummary();
        if (refreshed != null) {
          debugPrint('[DashboardController] Local dashboard summary created/updated from API. lastUpdatedAt=${refreshed.lastUpdatedAt.toIso8601String()}');
          summary.value = refreshed.summary;
          lastUpdatedAt.value = refreshed.lastUpdatedAt;
        }
      } else {
        errorMessage.value = 'Failed to load attendance summary';
      }
    } catch (e, stack) {
      errorMessage.value = 'Failed to load attendance summary';
      debugPrint('[DashboardController] Error loading attendance summary: $e');
      debugPrint(stack.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<AttendanceSummary?> _fetchSummaryFromApi() async {
    try {
      final user = HiveService.getUser();
      final employeeId = user?.employeeDto?.id;

      if (employeeId == null) {
        errorMessage.value = 'Employee ID not found';
        return null;
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
        return null;
      }

      final data = result.data!.first;
      final events = data.event ?? <AttendanceSummaryDto>[];

      return _buildAttendanceSummary(
        events: events,
        year: data.year,
        month: data.month,
      );
    } catch (e, stack) {
      debugPrint('[DashboardController] Error fetching attendance summary: $e');
      debugPrint(stack.toString());
      return null;
    }
  }

  AttendanceSummary _buildAttendanceSummary({
    required List<AttendanceSummaryDto> events,
    required int year,
    required int month,
  }) {
    if (events.isEmpty) {
      debugPrint('[DashboardController] No events to process');
      return const AttendanceSummary(
        workingDays: 0,
        onTime: 0,
        late: 0,
        absent: 0,
        businessTrip: 0,
        leave: 0,
        pending: 0,
        lastUpdate: '',
      );
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
    final formattedLastUpdate = DateFormat('yyyy-MM-dd, HH:mm:ss').format(lastDate);

    debugPrint('[DashboardController] Summary computed: '
        'workingDays=$workingDays, onTime=$onTime, late=$late, absent=$absent, '
        'businessTrip=$businessTrip, leave=$leave, pending=$pending, '
        'lastUpdate=$formattedLastUpdate');

    return AttendanceSummary(
      workingDays: workingDays,
      onTime: onTime,
      late: late,
      absent: absent,
      businessTrip: businessTrip,
      leave: leave,
      pending: pending,
      lastUpdate: formattedLastUpdate,
    );
  }

  Future<void> _cacheSummary(AttendanceSummary summary) async {
    final now = DateTime.now();
    final data = <String, dynamic>{
      'workingDays': summary.workingDays,
      'onTime': summary.onTime,
      'late': summary.late,
      'absent': summary.absent,
      'businessTrip': summary.businessTrip,
      'leave': summary.leave,
      'pending': summary.pending,
      'lastUpdate': summary.lastUpdate,
      'lastUpdatedAt': now.toIso8601String(),
    };

    debugPrint('[DashboardController] Saving dashboard summary to local storage. lastUpdatedAt=${data['lastUpdatedAt']}');

    await HiveService.saveDashboardSummary(data);
  }

  _CachedSummary? _readCachedSummary() {
    final raw = HiveService.getDashboardSummary();
    if (raw == null) {
      debugPrint('[DashboardController] No cached dashboard summary found in local storage.');
      return null;
    }

    try {
      final lastUpdatedIso = raw['lastUpdatedAt'] as String?;
      if (lastUpdatedIso == null) {
        debugPrint('[DashboardController] Cached dashboard summary missing lastUpdatedAt.');
        return null;
      }
      final lastUpdatedAt = DateTime.parse(lastUpdatedIso);

      final summary = AttendanceSummary(
        workingDays: (raw['workingDays'] as int?) ?? 0,
        onTime: (raw['onTime'] as int?) ?? 0,
        late: (raw['late'] as int?) ?? 0,
        absent: (raw['absent'] as int?) ?? 0,
        businessTrip: (raw['businessTrip'] as int?) ?? 0,
        leave: (raw['leave'] as int?) ?? 0,
        pending: (raw['pending'] as int?) ?? 0,
        lastUpdate: (raw['lastUpdate'] as String?) ?? '',
      );

      debugPrint('[DashboardController] Cached dashboard summary loaded from local storage. lastUpdatedAt=$lastUpdatedIso');

      return _CachedSummary(summary: summary, lastUpdatedAt: lastUpdatedAt);
    } catch (e, stack) {
      debugPrint('[DashboardController] Error reading cached summary: $e');
      debugPrint(stack.toString());
      return null;
    }
  }
}

class _CachedSummary {
  final AttendanceSummary summary;
  final DateTime lastUpdatedAt;

  _CachedSummary({
    required this.summary,
    required this.lastUpdatedAt,
  });
}
