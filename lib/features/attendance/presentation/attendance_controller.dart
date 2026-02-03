import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:local_auth/local_auth.dart';
import '../domain/entity/attendance_record.dart';

class AttendanceController extends GetxController {
  final RxList<AttendanceRecord> attendanceRecords = <AttendanceRecord>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // New reactive state for the new screen
  final Rx<File?> imageFile = Rx<File?>(null);
  final RxBool isFingerprintVerified = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxBool isCheckingBiometrics = false.obs;

  // Location state
  final RxString currentAddress = 'Fetching location...'.obs;
  final RxBool isLoadingLocation = false.obs;
  final RxString latitude = ''.obs;
  final RxString longitude = ''.obs;

  // Biometric authentication
  final LocalAuthentication _localAuth = LocalAuthentication();
  final RxBool canCheckBiometrics = false.obs;
  final RxString biometricType = ''.obs;
  
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    checkBiometricAvailability();
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoadingLocation.value = true;
      currentAddress.value = 'Fetching location...';
      
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        currentAddress.value = 'Location services are disabled';
        isLoadingLocation.value = false;
        return;
      }
      
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          currentAddress.value = 'Location permissions are denied';
          isLoadingLocation.value = false;
          return;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        currentAddress.value = 'Location permissions are permanently denied';
        isLoadingLocation.value = false;
        return;
      }
      
      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
      
      // Reverse geocoding to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = _formatAddress(place);
        currentAddress.value = address;
      } else {
        currentAddress.value = 'Address not found';
      }
      
    } catch (e) {
      currentAddress.value = 'Failed to get location';
      Get.snackbar(
        'Error',
        'Failed to get location: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingLocation.value = false;
    }
  }

  String _formatAddress(Placemark place) {
    List<String> addressParts = [];
    
    if (place.street?.isNotEmpty == true) {
      addressParts.add(place.street!);
    }
    if (place.subLocality?.isNotEmpty == true) {
      addressParts.add(place.subLocality!);
    }
    if (place.locality?.isNotEmpty == true) {
      addressParts.add(place.locality!);
    }
    if (place.administrativeArea?.isNotEmpty == true) {
      addressParts.add(place.administrativeArea!);
    }
    if (place.country?.isNotEmpty == true) {
      addressParts.add(place.country!);
    }
    
    return addressParts.isNotEmpty ? addressParts.join(', ') : 'Unknown location';
  }

  Future<void> takePicture() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.front,
      );

      if (image != null) {
        imageFile.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to take picture: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  bool canSubmit() {
    return imageFile.value != null && isFingerprintVerified.value && currentAddress.value != 'Fetching location...';
  }

  Future<void> submitAttendance() async {
    if (!canSubmit()) {
      Get.snackbar(
        'Incomplete',
        'Please complete all required fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isSubmitting.value = true;
      
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Add new attendance record
      final newRecord = AttendanceRecord(
        date: DateTime.now(),
        employeeId: 'EMP001',
        checkInTime: DateTime.now(),
        status: 'Present',
        notes: 'Picture and fingerprint verified at ${currentAddress.value}',
      );
      
      attendanceRecords.insert(0, newRecord);
      
      Get.snackbar(
        'Success',
        'Attendance submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Reset form
      imageFile.value = null;
      isFingerprintVerified.value = false;
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit attendance: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> verifyFingerprint() async {
    if (!canCheckBiometrics.value) {
      Get.snackbar(
        'Error',
        'Biometric authentication is not available on this device',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isCheckingBiometrics.value = true;

      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to verify your attendance',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        isFingerprintVerified.value = true;
        Get.snackbar(
          'Verified',
          'Biometric verification successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Authentication Failed',
          'Biometric verification was cancelled or failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } on PlatformException catch (e) {
      isFingerprintVerified.value = false;
      Get.snackbar(
        'Error',
        'Biometric authentication error: ${e.message ?? "Unknown error"}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      isFingerprintVerified.value = false;
      Get.snackbar(
        'Error',
        'Failed to verify biometric: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isCheckingBiometrics.value = false;
    }
  }

  Future<void> checkBiometricAvailability() async {
    try {
      canCheckBiometrics.value = await _localAuth.canCheckBiometrics;

      if (canCheckBiometrics.value) {
        List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();

        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          biometricType.value = 'Fingerprint';
        } else if (availableBiometrics.contains(BiometricType.face)) {
          biometricType.value = 'Face ID';
        } else if (availableBiometrics.contains(BiometricType.iris)) {
          biometricType.value = 'Iris';
        } else {
          biometricType.value = 'Biometric';
        }
      }
    } catch (e) {
      canCheckBiometrics.value = false;
    }
  }

  // Keep existing methods for compatibility
  Future<void> fetchAttendanceRecords() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      await Future.delayed(const Duration(seconds: 1));
      
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
      await Future.delayed(const Duration(seconds: 1));
      
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
      await Future.delayed(const Duration(seconds: 1));
      
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
