import '../entity/attendance.dart';

abstract class AttendanceRepository {
  Future<List<Attendance>> getThreeMonthWorkCalendar({
    required String employeeId,
    required int year,
    required int month,
  });
}
