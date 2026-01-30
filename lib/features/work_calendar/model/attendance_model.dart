import '../../work_calendar/domain/entity/attendance.dart';
import '../../work_calendar/domain/entity/attendance_event_type.dart';

class AttendanceModel {
  final DateTime date;
  final AttendanceEventType status;
  final String? description;

  AttendanceModel({
    required this.date,
    required this.status,
    this.description,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      date: DateTime.parse(json['date']),
      status: AttendanceEventTypeX.fromString(json['status'] ?? ''),
      description: json['description'],
    );
  }

  Attendance toEntity() => Attendance(date: date, status: status, description: description);
}
