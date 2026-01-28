import '../entity/authentication_tokens.dart';

abstract class AuthRepository {
  Future<(AuthenticationTokens?, String?)> login(String email, String password);
  Future<void> saveTokens(AuthenticationTokens tokens);
  Future<AuthenticationTokens?> getTokens();
  Future<void> clearTokens();
}
