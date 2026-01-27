import 'employee_acl_data_source.dart';
import 'employee_dto.dart';

class EmployeeAclRepository {
  final EmployeeAclDataSource dataSource = EmployeeAclDataSource();

  Future<EmployeeDto?> fetchAclEmployee({required String accessToken}) async {
    final json = await dataSource.fetchEmployeeAcl(accessToken: accessToken);
    if (json != null) {
      return EmployeeDto.fromJson(json);
    }
    return null;
  }
}
