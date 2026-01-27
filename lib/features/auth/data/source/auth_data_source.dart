import '../../domain/entity/authentication_tokens.dart';
import '../../../../core/network/api_client.dart';

class AuthDataSource {
  final ApiClient _client = ApiClient(
    'https://wf.dev.neo-fusion.com/fira-api/'
  );

  Future<(AuthenticationTokens?, String?)> login(String username, String password) async {
    try {
      final String encodedCredentials = "ZmlyYS1hcGktY2xpZW50OnBsZWFzZS1jaGFuZ2UtdGhpcw";
      
      final response = await _client.post(
      "oauth/token",
      headers: {'Authorization': 'Basic $encodedCredentials'},
      body: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        },
      );

      if (response != null && response['access_token'] != null) {
        return (AuthenticationTokens.fromJson(response), null);
      } else {
        return (null, 'Invalid response from server');
      }
    } on ApiException catch (e) {
      return (null, e.message);
    } catch (e) {
      return (null, e.toString());
    }
      
  }
}
