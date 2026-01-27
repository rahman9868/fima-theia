import '../../../core/network/api_client.dart';

class EmployeeAclDataSource {
  final ApiClient _client = ApiClient('https://wf.dev.neo-fusion.com/fira-api/');

  Future<Map<String, dynamic>?> fetchEmployeeAcl({required String accessToken}) async {
    try {
      final response = await _client.get(
        'att/employee/acl',
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      return response;
    } catch (e) {
      // Optionally handle/log errors. Return null or throw as needed.
      return null;
    }
  }
}
