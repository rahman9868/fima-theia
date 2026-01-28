import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../../acl/data/employee_acl_repository_impl.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase = LoginUseCase(
    AuthRepositoryImpl(),
    EmployeeAclRepositoryImpl(),
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void login() async {
    isLoading.value = true;
    errorMessage.value = '';
    final email = emailController.text;
    final password = passwordController.text;
    final (user, apiError) = await _loginUseCase.login(email, password);
    isLoading.value = false;
    if (user != null) {
      // Session (tokens & employeeDto) is already persisted in Hive in the use case
      Get.snackbar('Success', 'Login successful!');
    } else {
      errorMessage.value = apiError ?? 'Invalid credentials';
      Get.snackbar('Error', errorMessage.value, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
