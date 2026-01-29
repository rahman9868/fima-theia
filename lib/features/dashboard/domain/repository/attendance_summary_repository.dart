import '../entity/attendance_summary_dto.dart';

abstract class AttendanceSummaryRepository {
  Future<DataAttendanceSummaryDto?> fetchAttendanceSummary({
    required int employeeId,
    required int year,
    required int month,
  });
}
