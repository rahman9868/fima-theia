import '../../../acl/domain/entity/employee_dto.dart';

class User {
  final String userId;
  final EmployeeDto? employeeDto;
  final String accessToken;
  final String? refreshToken;

  User({
    required this.userId,
    required this.employeeDto,
    required this.accessToken,
    this.refreshToken,
  });
}
