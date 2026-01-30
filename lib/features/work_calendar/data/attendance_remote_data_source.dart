import 'package:fima_theia_flutter/features/work_calendar/domain/entity/attendance_event.dart';
import 'package:fima_theia_flutter/core/network/api_client.dart';

class AttendanceRemoteDataSource {
  final ApiClient apiClient;

  AttendanceRemoteDataSource(this.apiClient);

  Future<List<AttendanceEvent>> fetchAttendanceEvents(String employeeId, DateTime from) async {
    final endpoint = '/att/workCalendar/$employeeId/${from.year}/${from.month}';
    final res = await apiClient.get(endpoint);
    if (res is Map && res['data'] is List) {
      final data = res['data'] as List;
      return data.map((e) => AttendanceEvent(
        date: DateTime.parse(e['date']),
        type: AttendanceEventType.values.firstWhere(
          (t) => t.value == (e['status'] as String),
          orElse: () => AttendanceEventType.working,
        ),
        description: e['description'],
      )).toList();
    } else {
      throw Exception('Failed to load attendance data');
    }
    }
}
