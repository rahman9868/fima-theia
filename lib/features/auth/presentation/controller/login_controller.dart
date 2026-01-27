import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/entity/authentication_tokens.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase = LoginUseCase();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void login() async {
    isLoading.value = true;
    errorMessage.value = '';
    final email = emailController.text;
    final password = passwordController.text;
    final tokens = await _loginUseCase.login(email, password);
    isLoading.value = false;
    if (tokens != null) {
      // handle successful login
      Get.snackbar('Success', 'Login successful!');
    } else {
      errorMessage.value = 'Invalid credentials';
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
