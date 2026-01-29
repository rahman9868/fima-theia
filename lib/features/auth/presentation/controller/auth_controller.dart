import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/domain/usecase/login_usecase.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../../acl/data/employee_acl_repository_impl.dart';
import '../../../../core/local/hive_service.dart';
import '../../../../core/routes/app_routes.dart';

class AuthController extends GetxController {
  final LoginUseCase _loginUseCase = LoginUseCase(
    AuthRepositoryImpl(),
    EmployeeAclRepositoryImpl(),
  );

  Future<void> logout(BuildContext context) async {
    await _loginUseCase.logout();
    await HiveService.clearDashboardSummary();
    context.go(AppRoutes.login);
  }
}
