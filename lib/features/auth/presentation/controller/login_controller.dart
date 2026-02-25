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
import '../../../assignment/domain/usecase/get_assignments_usecase.dart';
import '../../../assignment/data/assignment_repository_impl.dart';
import '../../../assignment/data/assignment_remote_data_source.dart';
import '../../../../core/network/api_client.dart';

class LoginController extends GetxController {
  late final LoginUseCase _loginUseCase;
  late final GetAssignmentsUseCase _getAssignmentsUseCase;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize LoginUseCase with all dependencies
    _loginUseCase = LoginUseCase(
      AuthRepositoryImpl(),
      EmployeeAclRepositoryImpl(),
    );
    // Initialize GetAssignmentsUseCase
    _getAssignmentsUseCase = GetAssignmentsUseCase(
      AssignmentRepositoryImpl(
        AssignmentRemoteDataSource(ApiClient()),
      ),
    );
  }

  Future<void> checkIsLoggedIn(BuildContext? context) async {
    final tokenProvider = Get.find<TokenProvider>();
    final token = await tokenProvider.getAccessToken();
    try {
      final userBox = await Hive.openBox<User>('userBox');
      final user = userBox.get('user');
      if (token != null &&
          token.isNotEmpty &&
          user != null &&
          context != null) {
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
      // Fetch and save assignments after successful login
      try {
        final assignments = await _getAssignmentsUseCase();
        await _getAssignmentsUseCase.saveAssignments(assignments);
        print('[Login] Successfully fetched and saved ${assignments.length} assignments');
      } catch (e) {
        print('[Login] Failed to fetch assignments: $e');
        // Continue with login even if assignment fetch fails
      }
      
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
