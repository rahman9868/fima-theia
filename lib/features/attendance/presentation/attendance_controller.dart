import 'package:get/get.dart';
import '../domain/entity/attendance_record.dart';

class AttendanceController extends GetxController {
  final RxList<AttendanceRecord> attendanceRecords = <AttendanceRecord>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> fetchAttendanceRecords() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - replace with actual API call
      final mockData = [
        AttendanceRecord(
          date: DateTime.now(),
          employeeId: 'EMP001',
          checkInTime: DateTime.now().subtract(const Duration(hours: 9)),
          checkOutTime: DateTime.now(),
          status: 'Present',
          notes: 'Regular attendance',
        ),
        AttendanceRecord(
          date: DateTime.now().subtract(const Duration(days: 1)),
          employeeId: 'EMP001',
          checkInTime: DateTime.now().subtract(const Duration(days: 1, hours: 9)),
          checkOutTime: DateTime.now().subtract(const Duration(days: 1)),
          status: 'Present',
          notes: '',
        ),
      ];
      
      attendanceRecords.value = mockData;
    } catch (e) {
      errorMessage.value = 'Failed to load attendance records: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkIn() async {
    try {
      isLoading.value = true;
      
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Add new attendance record
      final newRecord = AttendanceRecord(
        date: DateTime.now(),
        employeeId: 'EMP001',
        checkInTime: DateTime.now(),
        status: 'Checked In',
        notes: 'Manual check-in',
      );
      
      attendanceRecords.insert(0, newRecord);
      
      Get.snackbar(
        'Success',
        'Checked in successfully at ${DateTime.now().toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to check in: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkOut(String recordId) async {
    try {
      isLoading.value = true;
      
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Find and update the record
      final index = attendanceRecords.indexWhere((record) => 
          record.employeeId == 'EMP001' && record.checkOutTime == null);
      
      if (index != -1) {
        final updatedRecord = AttendanceRecord(
          date: attendanceRecords[index].date,
          employeeId: attendanceRecords[index].employeeId,
          checkInTime: attendanceRecords[index].checkInTime,
          checkOutTime: DateTime.now(),
          status: 'Checked Out',
          notes: attendanceRecords[index].notes,
        );
        
        attendanceRecords[index] = updatedRecord;
        
        Get.snackbar(
          'Success',
          'Checked out successfully at ${DateTime.now().toString()}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to check out: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}