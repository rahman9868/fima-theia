import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../auth/domain/entity/user.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../../acl/data/employee_acl_repository_impl.dart';
import '../../../../core/services/token_provider.dart';
import '../../../../core/routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase = LoginUseCase(
    AuthRepositoryImpl(),
    EmployeeAclRepositoryImpl(),
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> checkIsLoggedIn(BuildContext? context) async {
    final tokenProvider = Get.find<TokenProvider>();
    final token = await tokenProvider.getAccessToken();
    try {
      final userBox = await Hive.openBox<User>('userBox');
      final user = userBox.get('user');
      if (token != null && token.isNotEmpty && user != null && context != null) {
        context.go(AppRoutes.dashboard);
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
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
        context.go(AppRoutes.dashboard);
      }
    } else {
      errorMessage.value = apiError ?? 'Invalid credentials';
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage.value),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
