import '../../domain/entity/authentication_tokens.dart';
import '../../domain/repository/auth_repository.dart';
import '../source/auth_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _dataSource = AuthDataSource();
  final _secureStorage = const FlutterSecureStorage();
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  @override
  Future<(AuthenticationTokens?, String?)> login(String email, String password) async {
    return await _dataSource.login(email, password);
  }

  @override
  Future<void> saveTokens(AuthenticationTokens tokens) async {
    await _secureStorage.write(key: _accessTokenKey, value: tokens.accessToken);
    if (tokens.refreshToken != null) {
      await _secureStorage.write(key: _refreshTokenKey, value: tokens.refreshToken);
    }

    final token = await getTokens();
    print("[saveTokens] => ${token?.accessToken}");
  }

  @override
  Future<AuthenticationTokens?> getTokens() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    if (accessToken != null) {
      return AuthenticationTokens(accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  @override
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
