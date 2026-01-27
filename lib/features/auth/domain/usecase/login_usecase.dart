import '../entity/user_entity.dart';
import '../../data/repository/auth_repository_impl.dart';

class LoginUseCase {
  final AuthRepositoryImpl _repo = AuthRepositoryImpl();

  Future<UserEntity?> login(String email, String password) async {
    return await _repo.login(email, password);
  }
}