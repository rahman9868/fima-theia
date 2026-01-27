import '../../domain/entity/authentication_tokens.dart';
import '../source/auth_data_source.dart';

class AuthRepositoryImpl {
  final AuthDataSource _dataSource = AuthDataSource();

  Future<(AuthenticationTokens?, String?)> login(String email, String password) async {
    return await _dataSource.login(email, password);
  }
}
