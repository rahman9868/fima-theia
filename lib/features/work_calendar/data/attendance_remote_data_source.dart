import '../../../core/network/api_client.dart';
import '../model/attendance_model.dart';
import '../model/attendance_detail_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<List<AttendanceModel>> getThreeMonthWorkCalendar({
    required String employeeId,
    required int year,
    required int month,
  });

  Future<AttendanceDetailModel> getAttendanceDetail({
    required String employeeId,
    required int year,
    required int month,
    required int day,
  });
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final ApiClient apiClient;
  AttendanceRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<AttendanceModel>> getThreeMonthWorkCalendar({
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

  @override
  Future<AttendanceDetailModel> getAttendanceDetail({
    required String employeeId,
    required int year,
    required int month,
    required int day,
  }) async {
    final res = await apiClient.get('att/$employeeId/$year/$month/$day');
    return AttendanceDetailModel.fromJson(res);
  }
}
