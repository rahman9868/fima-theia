import '../../../../core/network/api_client.dart';
import '../domain/entity/assignment.dart';
import '../domain/entity/schedule.dart';

class AssignmentRemoteDataSource {
  final ApiClient _apiClient;

  AssignmentRemoteDataSource(this._apiClient);

  Future<List<Assignment>> getAssignmentsBySchedule() async {
    try {
      final response = await _apiClient.get('assignment/by-schedule');
      if (response is List) {
        return response
            .map((json) => Assignment.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch assignments: $e');
    }
  }

  Future<List<Schedule>> getScheduleEmployee() async {
    try {
      final response = await _apiClient.get('att/schedule/employee');
      if (response is Map && response.containsKey('data')) {
        final data = response['data'] as List;
        return data
            .map((json) => Schedule.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch schedule: $e');
    }
  }

  Future<List<FlexibleSchedule>> getFlexibleScheduleEmployee() async {
    try {
      final response = await _apiClient.get('att/schedule-flexible/employee');
      if (response is Map && response.containsKey('data')) {
        final data = response['data'] as List;
        return data
            .map((json) =>
                FlexibleSchedule.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch flexible schedule: $e');
    }
  }

  Future<List<FlexibleTempSchedule>> getFlexibleTempScheduleEmployee() async {
    try {
      final response =
          await _apiClient.get('att/schedule-flexible-temp/employee');
      if (response is Map && response.containsKey('data')) {
        final data = response['data'] as List;
        return data
            .map((json) =>
                FlexibleTempSchedule.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch flexible temp schedule: $e');
    }
  }
}