import '../entity/global_config.dart';
import '../repository/global_config_repository.dart';

class GetCachedGlobalConfigWithTimestampUseCase {
  final GlobalConfigRepository _repository;

  GetCachedGlobalConfigWithTimestampUseCase(this._repository);

  /// Returns (configs, timestamp) tuple
  /// Use this to get cached configs with information about when they were saved
  Future<(List<GlobalConfig>?, DateTime?)> call() async {
    try {
      final configs = await _repository.getCachedGlobalConfig();
      final timestamp = await _repository.getConfigsCachedTimestamp();
      return (configs, timestamp);
    } catch (e) {
      print('[GetCachedGlobalConfigWithTimestampUseCase] Error: $e');
      return (null, null);
    }
  }
}
