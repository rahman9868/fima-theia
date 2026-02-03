import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              
              // Location Section
              _buildSectionTitle('Location'),
              const SizedBox(height: 12),
              Obx(() {
                if (controller.isLoadingLocation.value) {
                  return const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Getting location...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: [
                    Center(
                      child: Icon(
                        Icons.location_on,
                        size: 32,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        controller.currentAddress.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                );
              }),
              
              const SizedBox(height: 32),
              
              // Picture Section
              _buildSectionTitle('Picture'),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: controller.takePicture,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Obx(() => controller.imageFile.value != null
                      ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                controller.imageFile.value!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  controller.imageFile.value = null;
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 48,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Take Selfie',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Front Camera',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        )),
                ),
              ),
              
              const SizedBox(height: 32),

              // Fingerprint Section
              _buildSectionTitle('Biometric Verification'),
              const SizedBox(height: 12),
              Obx(() {
                if (!controller.canCheckBiometrics.value) {
                  return Column(
                    children: [
                      Icon(
                        Icons.fingerprint,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Biometric not available',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  );
                }

                return GestureDetector(
                  onTap: controller.isFingerprintVerified.value
                      ? null
                      : controller.verifyFingerprint,
                  child: Center(
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          child: Stack(
                            children: [
                              Icon(
                                controller.biometricType.value == 'Face ID'
                                    ? Icons.face
                                    : Icons.fingerprint,
                                size: 64,
                                color: controller.isFingerprintVerified.value
                                    ? Colors.green
                                    : (controller.isCheckingBiometrics.value
                                        ? Colors.orange
                                        : Colors.grey[400]),
                              ),
                              if (controller.isCheckingBiometrics.value)
                                Positioned.fill(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      controller.biometricType.value == 'Face ID'
                                          ? Colors.orange.withOpacity(0.8)
                                          : Colors.grey[400]!,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.isCheckingBiometrics.value
                              ? 'Verifying...'
                              : (controller.isFingerprintVerified.value
                                  ? '${controller.biometricType.value} Verified'
                                  : 'Tap to verify with ${controller.biometricType.value}'),
                          style: TextStyle(
                            fontSize: 14,
                            color: controller.isFingerprintVerified.value
                                ? Colors.green
                                : (controller.isCheckingBiometrics.value
                                    ? Colors.orange
                                    : Colors.grey[600]),
                            fontWeight: controller.isFingerprintVerified.value
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              
              const Spacer(flex: 2),
              
              // Primary Action Button
              Obx(() => ElevatedButton(
                onPressed: controller.canSubmit()
                    ? controller.submitAttendance
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                  disabledForegroundColor: Colors.grey[500],
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: controller.isSubmitting.value || controller.isCheckingBiometrics.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'ATTENDANCE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
              )),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}
