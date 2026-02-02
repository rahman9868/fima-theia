import '../../model/attendance_detail_model.dart';
import '../entity/attendance.dart';

abstract class AttendanceRepository {
  Future<List<Attendance>> getThreeMonthWorkCalendar({
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
