import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF166DB2), // Matches background gradients/shades
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 4),
                    const Text(
                      'FIFGROUP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF444444)),
                    ),
                    // LOGO IMAGE (adjust path as needed)
                    const SizedBox(height: 18),
                    Image(
                      image: AssetImage('assets/img/logo.png'),
                      height: 64,
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 15),
                        children: [
                          TextSpan(
                            text: 'member of ',
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextSpan(
                            text: 'ASTRA',
                            style: TextStyle(
                                color: Color(0xFF1874ce), fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Mobile Attendance',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        color: Color(0xFF444444),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1.45.8-dev',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF1874ce),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 44),

                    TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: const TextStyle(color: Color(0xFFBFBFBF)),
                        fillColor: const Color(0xFFF6F6F6),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF166DB2), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF166DB2), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF166DB2), width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
                      ),
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller.passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Color(0xFFBFBFBF)),
                        fillColor: const Color(0xFFF6F6F6),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF166DB2), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF166DB2), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF166DB2), width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 28),
                    Obx(() {
                      return controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () => controller.login(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF7B94C),
                                  shadowColor: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.normal),
                                ),
                              ),
                            );
                    }),
                    Obx(() {
                      return controller.errorMessage.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Text(
                                controller.errorMessage.value,
                                style: const TextStyle(
                                    color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            )
                          : const SizedBox();
                    }),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
              // FOOTER
              const SizedBox(height: 30),
              const Text(
                '@2019 PT Federal International Finance',
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const Text(
                '1.45.8-dev',
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
