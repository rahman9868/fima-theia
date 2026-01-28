import 'employee_acl_data_source.dart';
import '../domain/entity/employee_dto.dart';
import '../domain/repository/employee_acl_repository.dart';

class EmployeeAclRepositoryImpl implements EmployeeAclRepository {
  final EmployeeAclDataSource dataSource = EmployeeAclDataSource();

  @override
  Future<EmployeeDto?> fetchAclEmployee({required String accessToken}) async {
    final json = await dataSource.fetchEmployeeAcl();
    if (json != null) {
      return EmployeeDto.fromJson(json);
    }
    return null;
  }
}
