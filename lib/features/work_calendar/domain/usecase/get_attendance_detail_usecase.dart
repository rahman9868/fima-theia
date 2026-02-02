import '../../model/attendance_detail_model.dart';
import '../repository/attendance_repository.dart';

class GetAttendanceDetailUseCase {
  final AttendanceRepository repository;
  GetAttendanceDetailUseCase({required this.repository});

  Future<AttendanceDetailModel> call({
    required String employeeId,
    required int year,
    required int month,
    required int day,
  }) async {
    return repository.getAttendanceDetail(
      employeeId: employeeId,
      year: year,
      month: month,
      day: day,
    );
  }
}
