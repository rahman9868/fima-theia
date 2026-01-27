import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/entity/user_entity.dart';

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
    final user = await _loginUseCase.login(email, password);
    isLoading.value = false;
    if (user != null) {
      // handle successful login
      Get.snackbar('Success', 'Welcome, \\${user.email}!');
    } else {
      errorMessage.value = 'Invalid credentials';
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
