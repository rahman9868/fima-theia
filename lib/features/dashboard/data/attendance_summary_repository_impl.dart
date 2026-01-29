import 'attendance_summary_data_source.dart';
import '../domain/entity/attendance_summary_dto.dart';
import '../domain/repository/attendance_summary_repository.dart';

class AttendanceSummaryRepositoryImpl implements AttendanceSummaryRepository {
  final AttendanceSummaryDataSource _dataSource = AttendanceSummaryDataSource();

  @override
  Future<DataAttendanceSummaryDto?> fetchAttendanceSummary({
    required int employeeId,
    required int year,
    required int month,
  }) async {
    final json = await _dataSource.fetchAttendanceSummary(
      employeeId: employeeId,
      year: year,
      month: month,
    );
    if (json != null) {
      return DataAttendanceSummaryDto.fromJson(json);
    }
    return null;
  }
}
