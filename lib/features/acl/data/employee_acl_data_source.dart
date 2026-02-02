import '../../../core/network/api_client.dart';

class EmployeeAclDataSource {
  final ApiClient _client = ApiClient();

  Future<Map<String, dynamic>?> fetchEmployeeAcl() async {
    try {
      final response = await _client.get('att/employee/acl');
      return response;
    } catch (e) {
      // Optionally handle/log errors. Return null or throw as needed.
      return null;
    }
  }
}
