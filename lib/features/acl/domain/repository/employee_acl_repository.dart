import '../entity/employee_dto.dart';

abstract class EmployeeAclRepository {
  Future<EmployeeDto?> fetchAclEmployee({required String accessToken});
}
