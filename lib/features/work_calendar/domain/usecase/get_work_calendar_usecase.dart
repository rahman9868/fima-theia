import '../entity/attendance.dart';
import '../repository/attendance_repository.dart';

class GetWorkCalendarUsecase {
  final AttendanceRepository repository;
  GetWorkCalendarUsecase({required this.repository});

  Future<List<Attendance>> call({
    required String employeeId,
    required int year,
    required int month,
  }) async {
    return repository.getWorkCalendar(employeeId: employeeId, year: year, month: month);
  }
}
