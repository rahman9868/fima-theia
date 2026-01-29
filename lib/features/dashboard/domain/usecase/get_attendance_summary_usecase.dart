import '../entity/attendance_summary_dto.dart';
import '../repository/attendance_summary_repository.dart';

class GetAttendanceSummaryUseCase {
  final AttendanceSummaryRepository _repository;

  GetAttendanceSummaryUseCase(this._repository);

  Future<DataAttendanceSummaryDto?> execute({
    required int employeeId,
    required int year,
    required int month,
  }) {
    return _repository.fetchAttendanceSummary(
      employeeId: employeeId,
      year: year,
      month: month,
    );
  }
}
