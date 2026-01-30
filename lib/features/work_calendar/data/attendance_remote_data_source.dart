import '../../../core/network/api_client.dart';
import '../model/attendance_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<List<AttendanceModel>> getWorkCalendar({
    required String employeeId,
    required int year,
    required int month,
  });
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final ApiClient apiClient;
  AttendanceRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<AttendanceModel>> getWorkCalendar({
    required String employeeId,
    required int year,
    required int month,
  }) async {
    final res = await apiClient.get('att/workCalendar/$employeeId/$year/$month');
    if (res['data'] is List) {
      return (res['data'] as List).map((e) => AttendanceModel.fromJson(e)).toList();
    }
    return [];
  }
}
