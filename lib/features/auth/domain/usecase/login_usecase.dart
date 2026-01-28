import '../../domain/repository/auth_repository.dart';
import '../entity/authentication_tokens.dart';

class LoginUseCase {
  final AuthRepository _repo;
  LoginUseCase(this._repo);

  Future<(AuthenticationTokens?, String?)> login(String email, String password) async {
    final (tokens, errorMsg) = await _repo.login(email, password);
    if (tokens != null && tokens.accessToken.isNotEmpty) {
      await _repo.saveTokens(tokens);
      return (tokens, null);
    }
    return (null, errorMsg);
  }

  Future<void> logout() async {
    await _repo.clearTokens();
  }

  Future<AuthenticationTokens?> getCurrentTokens() async => _repo.getTokens();
}
