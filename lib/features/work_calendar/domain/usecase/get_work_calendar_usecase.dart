import '../entity/attendance.dart';
import '../repository/attendance_repository.dart';

class GetThreeMonthWorkCalendarUsecase {
  final AttendanceRepository repository;
  GetThreeMonthWorkCalendarUsecase({required this.repository});

  Future<List<Attendance>> call({
    required String employeeId,
    required int year,
    required int month,
  }) async {
    return repository.getThreeMonthWorkCalendar(employeeId: employeeId, year: year, month: month);
  }
}
