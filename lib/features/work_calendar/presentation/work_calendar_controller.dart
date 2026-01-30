import 'package:get/get.dart';
import '../../../core/local/hive_service.dart';
import '../domain/entity/attendance.dart';
import '../domain/usecase/get_work_calendar_usecase.dart';

class WorkCalendarController extends GetxController {
  final GetWorkCalendarUsecase getWorkCalendarUsecase;
  var loading = false.obs;
  var error = ''.obs;
  var attendances = <DateTime, Attendance>{}.obs;

  WorkCalendarController({required this.getWorkCalendarUsecase});

  Future<void> loadCalendars(List<DateTime> months) async {
    final user = HiveService.getUser();
    final employeeId = user?.employeeDto?.id?.toString();
    if (employeeId == null) {
      error.value = 'Employee ID not found';
      return;
    }
    loading.value = true;
    error.value = '';
    try {
      final Map<DateTime, Attendance> newData = {};
      for (final month in months) {
        final list = await getWorkCalendarUsecase(
          employeeId: employeeId,
          year: month.year,
          month: month.month,
        );
        newData.addAll({for (var e in list) e.date: e});
      }
      attendances.value = newData;
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }
}
