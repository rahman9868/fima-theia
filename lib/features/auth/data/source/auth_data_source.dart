import '../../domain/entity/user_entity.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_provider.dart';

class AuthDataSource {
  Future<UserEntity?> login(String email, String password) async {
    try {
      final response = await ApiProvider().client.post(
        '/oauth/token',
        data: {
          'username': email,
          'password': password,
          'grant_type': 'password',
        },
      );
      if (response.data != null && response.data['access_token'] != null) {
        return UserEntity(
          email: email,
          token: response.data['access_token'],
          refreshToken: response.data['refresh_token'],
        );
      }
    } catch (e) {
      // Handle or log error if needed
    }
    return null;
  }
}
