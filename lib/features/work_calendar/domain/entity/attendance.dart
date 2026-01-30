import 'attendance_event_type.dart';

class Attendance {
  final DateTime date;
  final AttendanceEventType status;
  final String? description;

  Attendance({
    required this.date,
    required this.status,
    this.description,
  });
}
