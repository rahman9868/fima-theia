import 'package:hive/hive.dart';
import '../../../acl/domain/entity/employee_dto.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final EmployeeDto? employeeDto;

  @HiveField(2)
  final String accessToken;

  @HiveField(3)
  final String? refreshToken;

  User({
    required this.userId,
    required this.employeeDto,
    required this.accessToken,
    this.refreshToken,
  });
}
