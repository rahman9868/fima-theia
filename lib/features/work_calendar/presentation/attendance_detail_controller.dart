import 'package:get/get.dart';
import '../../../core/local/hive_service.dart';
import '../model/attendance_detail_model.dart';
import '../domain/usecase/get_attendance_detail_usecase.dart';

class AttendanceDetailController extends GetxController {
  final GetAttendanceDetailUseCase useCase;
  var loading = false.obs;
  var error = ''.obs;
  var detail = Rxn<AttendanceDetailModel>();

  AttendanceDetailController({required this.useCase});

  Future<void> load(DateTime date) async {
    final user = HiveService.getUser();
    final employeeId = user?.employeeDto?.id?.toString();
    if (employeeId == null) {
      error.value = 'Employee ID not found';
      return;
    }
    loading.value = true;
    error.value = '';
    try {
      final result = await useCase(
        employeeId: employeeId,
        year: date.year,
        month: date.month,
        day: date.day,
      );
      detail.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }
}
