import '../../work_calendar/domain/entity/attendance.dart';
import '../../work_calendar/domain/repository/attendance_repository.dart';
import '../model/attendance_model.dart';
import 'attendance_remote_data_source.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  AttendanceRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<Attendance>> getWorkCalendar({
    required String employeeId,
    required int year,
    required int month,
  }) async {
    final result = await remoteDataSource.getWorkCalendar(employeeId: employeeId, year: year, month: month);
    return result.map((e) => e.toEntity()).toList();
  }
}
