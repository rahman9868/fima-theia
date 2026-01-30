import 'package:fima_theia_flutter/features/work_calendar/domain/entity/attendance_event.dart';
import 'package:fima_theia_flutter/features/work_calendar/domain/repository/attendance_repository.dart';

class GetAttendanceEvents {
  final AttendanceRepository repository;

  GetAttendanceEvents(this.repository);

  Future<List<AttendanceEvent>> call(String employeeId, DateTime from) {
    return repository.fetchAttendanceEvents(employeeId, from);
  }
}
