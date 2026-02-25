import '../model/global_config_dto.dart';
import '../../../../core/network/api_client.dart';

class GlobalConfigDataSource {
  final ApiClient _client = ApiClient();

  Future<List<GlobalConfigDto>> getGlobalConfig() async {
    try {
      final response = await _client.get('fira/config/firaconfig');

      if (response is List) {
        return response
            .map(
              (item) => GlobalConfigDto.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      } else if (response is Map) {
        final configList = response['data'] as List?;
        if (configList != null) {
          return configList
              .map(
                (item) =>
                    GlobalConfigDto.fromJson(item as Map<String, dynamic>),
              )
              .toList();
        }
      }

      return [];
    } catch (e) {
      throw Exception('Failed to fetch global config: $e');
    }
  }
}
