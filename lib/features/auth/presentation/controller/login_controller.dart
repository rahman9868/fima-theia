import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../../auth/domain/entity/user.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../../acl/data/employee_acl_repository_impl.dart';
import '../../../../core/services/token_provider.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase = LoginUseCase(
    AuthRepositoryImpl(),
    EmployeeAclRepositoryImpl(),
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkIsLoggedIn();
  }

  Future<void> _checkIsLoggedIn() async {
    final tokenProvider = Get.find<TokenProvider>();
    final token = await tokenProvider.getAccessToken();
    // User profile from Hive (if exists)
    try {
      final userBox = await Hive.openBox<User>('userBox');
      final user = userBox.get('profile');
      if (token != null && token.isNotEmpty && user != null) {
        // ignore context = null warning because onInit runs before context assigned.
        // Navigation context passed from app layer.
        Future.delayed(Duration.zero, () {
          final context = Get.context;
          if (context != null) {
            context.go('/dashboard');
          }
        });
      }
    } catch (_) {}
  }

  void login([BuildContext? context]) async {
    isLoading.value = true;
    errorMessage.value = '';
    final email = emailController.text;
    final password = passwordController.text;
    final (user, apiError) = await _loginUseCase.login(email, password);
    isLoading.value = false;
    if (user != null) {
      Get.snackbar('Success', 'Login successful!');
      if(context != null) context.go('/dashboard');
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
