import '../../domain/entity/authentication_tokens.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_provider.dart';

class AuthDataSource {
  Future<AuthenticationTokens?> login(String email, String password) async {
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
        return AuthenticationTokens.fromJson(response.data);
      }
    } catch (e) {
      // Handle or log error if needed
    }
    return null;
  }
}
