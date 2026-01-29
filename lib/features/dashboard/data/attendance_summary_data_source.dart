import '../../../core/network/api_client.dart';

class AttendanceSummaryDataSource {
  final ApiClient _client =
      ApiClient('https://wf.dev.neo-fusion.com/fira-api/');

  Future<Map<String, dynamic>?> fetchAttendanceSummary(
      {required int employeeId,
      required int year,
      required int month}) async {
    try {
      final response = await _client
          .get('att/attendanceSummary/$employeeId/$year/$month');
      if (response is Map<String, dynamic>) {
        return response;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}