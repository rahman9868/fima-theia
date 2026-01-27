import '../entity/authentication_tokens.dart';
import '../../data/repository/auth_repository_impl.dart';

class LoginUseCase {
  final AuthRepositoryImpl _repo = AuthRepositoryImpl();

  Future<AuthenticationTokens?> login(String email, String password) async {
    return await _repo.login(email, password);
  }
}