import 'package:get/get.dart';
import '../../domain/entity/attendance_summary_dto.dart';
import '../../domain/usecase/get_attendance_summary_usecase.dart';
import '../../data/attendance_summary_repository_impl.dart';
import '../../../../core/local/hive_service.dart';

class DashboardController extends GetxController {
  final GetAttendanceSummaryUseCase _getAttendanceSummaryUseCase =
      GetAttendanceSummaryUseCase(AttendanceSummaryRepositoryImpl());

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var attendanceSummary = Rxn<DataAttendanceSummaryDto>();

  @override
  void onInit() {
    super.onInit();
    _loadAttendanceSummary();
  }

  Future<void> _loadAttendanceSummary() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final user = HiveService.getUser();
      final employeeId = user?.employeeDto?.id;

      if (employeeId == null) {
        errorMessage.value = 'Employee ID not found';
        isLoading.value = false;
        return;
      }

      final now = DateTime.now();
      final result = await _getAttendanceSummaryUseCase.execute(
        employeeId: employeeId,
        year: now.year,
        month: now.month,
      );

      if (result != null) {
        attendanceSummary.value = result;
      } else {
        errorMessage.value = 'No attendance data found';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
