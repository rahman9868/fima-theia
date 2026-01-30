import 'package:fima_theia_flutter/features/work_calendar/domain/entity/attendance_event.dart';
import 'package:fima_theia_flutter/features/work_calendar/domain/repository/attendance_repository.dart';
import 'package:fima_theia_flutter/features/work_calendar/data/attendance_remote_data_source.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AttendanceEvent>> fetchAttendanceEvents(String employeeId, DateTime from) {
    return remoteDataSource.fetchAttendanceEvents(employeeId, from);
  }
}
