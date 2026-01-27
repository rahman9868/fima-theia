import '../../domain/entity/user_entity.dart';
import '../source/auth_data_source.dart';

class AuthRepositoryImpl {
  final AuthDataSource _dataSource = AuthDataSource();

  Future<UserEntity?> login(String email, String password) async {
    return await _dataSource.login(email, password);
  }
}