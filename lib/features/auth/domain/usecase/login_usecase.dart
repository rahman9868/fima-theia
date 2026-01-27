import '../../data/repository/auth_repository_impl.dart';
import '../entity/authentication_tokens.dart';
import '../../../acl/data/employee_acl_repository_impl.dart';
import '../../../acl/domain/entity/employee_dto.dart';
import '../entity/user.dart';

class LoginUseCase {
  final AuthRepositoryImpl _repo = AuthRepositoryImpl();
  final EmployeeAclRepositoryImpl _aclRepo = EmployeeAclRepositoryImpl();

  Future<(User?, String?)> login(String email, String password) async {
    final (tokens, errorMsg) = await _repo.login(email, password);
    if (tokens != null && tokens.accessToken.isNotEmpty) {
      final acl = await _aclRepo.fetchAclEmployee(accessToken: tokens.accessToken);
      final user = User(
        userId: email,
        employeeDto: acl,
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
      return (user, null);
    }
    return (null, errorMsg);
  }
}
