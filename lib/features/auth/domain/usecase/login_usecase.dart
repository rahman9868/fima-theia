import '../../domain/repository/auth_repository.dart';
import '../entity/authentication_tokens.dart';
import '../../../acl/data/employee_acl_repository_impl.dart';
import '../entity/user.dart';
import '../../../../core/local/hive_service.dart';
import '../usecase/get_global_config_usecase.dart';
import '../../data/repository/global_config_repository_impl.dart';

class LoginUseCase {
  final AuthRepository _repo;
  final EmployeeAclRepositoryImpl _aclRepo;
  final GetGlobalConfigUseCase _getGlobalConfigUseCase;

  LoginUseCase(
    this._repo,
    this._aclRepo, {
    GetGlobalConfigUseCase? getGlobalConfigUseCase,
  }) : _getGlobalConfigUseCase =
           getGlobalConfigUseCase ??
           GetGlobalConfigUseCase(GlobalConfigRepositoryImpl());

  Future<(User?, String?)> login(String email, String password) async {
    final (tokens, errorMsg) = await _repo.login(email, password);
    if (tokens != null && tokens.accessToken.isNotEmpty) {
      await _repo.saveTokens(tokens);
      final acl = await _aclRepo.fetchAclEmployee(
        accessToken: tokens.accessToken,
      );
      final user = User(
        userId: email,
        employeeDto: acl,
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
      await HiveService.saveUser(user);

      // Fetch and cache global config after successful login
      try {
        final (configs, configError) = await _getGlobalConfigUseCase();
        if (configs != null) {
          print(
            '[LoginUseCase] Global config fetched successfully: ${configs.length} items',
          );
        } else if (configError != null) {
          print('[LoginUseCase] Error fetching global config: $configError');
        }
      } catch (e) {
        print('[LoginUseCase] Exception fetching global config: $e');
      }

      return (user, null);
    }
    return (null, errorMsg);
  }

  Future<void> logout() async {
    await _repo.clearTokens();
    await HiveService.deleteUser();
  }

  Future<AuthenticationTokens?> getCurrentTokens() async => _repo.getTokens();
}
