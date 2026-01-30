import '../entity/attendance.dart';

abstract class AttendanceRepository {
  Future<List<Attendance>> getWorkCalendar({
    required String employeeId,
    required int year,
    required int month,
  });
}
