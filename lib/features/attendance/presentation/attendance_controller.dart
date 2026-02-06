import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

  // ScaffoldMessenger key for showing snackbars
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

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
      _showSnackbar('Error', 'Failed to get location: $e');
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

    return addressParts.isNotEmpty
        ? addressParts.join(', ')
        : 'Unknown location';
  }

  Future<void> takePicture() async {
    // Navigate to custom camera screen
    // The camera screen will call onPictureTaken with the image path
    // This is handled by the UI layer which will call setImagePath
  }

  void setImagePath(String path) {
    imageFile.value = File(path);
  }

  bool canSubmit() {
    return imageFile.value != null &&
        isFingerprintVerified.value &&
        currentAddress.value != 'Fetching location...';
  }

  Future<void> submitAttendance() async {
    if (!canSubmit()) {
      _showSnackbar('Incomplete', 'Please complete all required fields');
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

      _showSnackbar(
        'Success',
        'Attendance submitted successfully',
        backgroundColor: Colors.green,
      );

      // Reset form
      imageFile.value = null;
      isFingerprintVerified.value = false;
    } catch (e) {
      _showSnackbar('Error', 'Failed to submit attendance: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> verifyFingerprint() async {
    if (!canCheckBiometrics.value) {
      _showSnackbar(
        'Error',
        'Biometric authentication is not available on this device',
        backgroundColor: Colors.red,
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
        _showSnackbar(
          'Verified',
          'Biometric verification successful',
          backgroundColor: Colors.green,
        );
      } else {
        _showSnackbar(
          'Authentication Failed',
          'Biometric verification was cancelled or failed',
          backgroundColor: Colors.orange,
        );
      }
    } on PlatformException catch (e) {
      isFingerprintVerified.value = false;
      _showSnackbar(
        'Error',
        'Biometric authentication error: ${e.message ?? "Unknown error"}',
        backgroundColor: Colors.red,
      );
    } catch (e) {
      isFingerprintVerified.value = false;
      _showSnackbar('Error', 'Failed to verify biometric: $e');
    } finally {
      isCheckingBiometrics.value = false;
    }
  }

  void _showSnackbar(String title, String message, {Color? backgroundColor}) {
    try {
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title: $message'),
            backgroundColor: backgroundColor ?? Colors.grey,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Silently fail if snackbar cannot be shown
      debugPrint('Failed to show snackbar: $e');
    }
  }

  Future<void> checkBiometricAvailability() async {
    try {
      canCheckBiometrics.value = await _localAuth.canCheckBiometrics;

      if (canCheckBiometrics.value) {
        List<BiometricType> availableBiometrics = await _localAuth
            .getAvailableBiometrics();

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
          checkInTime: DateTime.now().subtract(
            const Duration(days: 1, hours: 9),
          ),
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

      _showSnackbar(
        'Success',
        'Checked in successfully at ${DateTime.now().toString()}',
      );
    } catch (e) {
      _showSnackbar('Error', 'Failed to check in: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkOut(String recordId) async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));

      final index = attendanceRecords.indexWhere(
        (record) =>
            record.employeeId == 'EMP001' && record.checkOutTime == null,
      );

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

        _showSnackbar(
          'Success',
          'Checked out successfully at ${DateTime.now().toString()}',
        );
      }
    } catch (e) {
      _showSnackbar('Error', 'Failed to check out: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
