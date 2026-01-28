import '../../domain/entity/authentication_tokens.dart';
import '../../domain/repository/auth_repository.dart';
import '../source/auth_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _dataSource = AuthDataSource();
  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<(AuthenticationTokens?, String?)> login(String email, String password) async {
    return await _dataSource.login(email, password);
  }

  @override
  Future<void> saveTokens(AuthenticationTokens tokens) async {
    await _secureStorage.write(key: 'accessToken', value: tokens.accessToken);
    if (tokens.refreshToken != null) {
      await _secureStorage.write(key: 'refreshToken', value: tokens.refreshToken);
    }
    print("[saveTokens] => ${tokens.accessToken}");
  }

  @override
  Future<AuthenticationTokens?> getTokens() async {
    final accessToken = await _secureStorage.read(key: 'accessToken');
    final refreshToken = await _secureStorage.read(key: 'refreshToken');
    if (accessToken != null) {
      return AuthenticationTokens(accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  @override
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');
  }
}
