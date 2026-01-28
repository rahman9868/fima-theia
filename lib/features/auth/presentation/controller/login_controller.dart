import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecase/login_usecase.dart';

import '../../data/repository/auth_repository_impl.dart';
class LoginController extends GetxController {
  final LoginUseCase _loginUseCase = LoginUseCase(AuthRepositoryImpl());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void login() async {
    isLoading.value = true;
    errorMessage.value = '';
    final email = emailController.text;
    final password = passwordController.text;
    final (tokens, apiError) = await _loginUseCase.login(email, password);
    isLoading.value = false;
    if (tokens != null) {
      // Session is saved in usecase
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
