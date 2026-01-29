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

  /// Single source of truth for the UI
  final Rx<AttendanceSummary?> summary = Rx<AttendanceSummary?>(null);

  /// When the summary was last updated from the API
  final Rx<DateTime?> lastUpdatedAt = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    loadDashboardSummary();
  }

  Future<void> refreshSummary() async {
    await loadDashboardSummary(forceRefresh: true);
  }

  /// Public entry point used by the UI.
  /// Implements the cache business rules:
  ///
  /// - If cached and < 5 minutes old: use cache only
  /// - If cached but stale: show cache, refresh from API in background
  /// - If no cache: fetch from API and cache
  Future<void> loadDashboardSummary({bool forceRefresh = false}) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final cached = _readCachedSummary();
      final now = DateTime.now();

      if (!forceRefresh && cached != null) {
        // Always show cached data first
        summary.value = cached.summary;
        lastUpdatedAt.value = cached.lastUpdatedAt;

        final isFresh = now.difference(cached.lastUpdatedAt) < _cacheValidity;
        if (isFresh) {
          // Fresh enough, no API call needed
          return;
        }

        // Stale: refresh from API, then update cache & in‑memory state
        final fresh = await _fetchSummaryFromApi();
        if (fresh != null) {
          await _cacheSummary(fresh);
          final refreshed = _readCachedSummary();
          if (refreshed != null) {
            summary.value = refreshed.summary;
            lastUpdatedAt.value = refreshed.lastUpdatedAt;
          }
        }
        return;
      }

      // No cache or forced refresh: fetch from API and cache
      final fresh = await _fetchSummaryFromApi();
      if (fresh != null) {
        await _cacheSummary(fresh);
        final refreshed = _readCachedSummary();
        if (refreshed != null) {
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

  /// Calls the API and converts the response into an [AttendanceSummary].
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

    await HiveService.saveDashboardSummary(data);
  }

  _CachedSummary? _readCachedSummary() {
    final raw = HiveService.getDashboardSummary();
    if (raw == null) return null;

    try {
      final lastUpdatedIso = raw['lastUpdatedAt'] as String?;
      if (lastUpdatedIso == null) return null;
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
