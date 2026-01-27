import '../../domain/entity/authentication_tokens.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_provider.dart';

class AuthDataSource {
  Future<(AuthenticationTokens?, String?)> login(String email, String password) async {
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
        return (AuthenticationTokens.fromJson(response.data), null);
      } else {
        return (null, 'Invalid response from server');
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data is Map && e.response?.data['error_description'] != null) {
        return (null, e.response?.data['error_description'].toString());
      } else {
        return (null, e.message);
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}
