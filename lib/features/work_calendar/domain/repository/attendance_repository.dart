import '../entity/attendance_event.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceEvent>> fetchAttendanceEvents(String employeeId, DateTime from);
}
