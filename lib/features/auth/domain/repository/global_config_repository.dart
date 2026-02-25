import '../entity/global_config.dart';

abstract class GlobalConfigRepository {
  Future<List<GlobalConfig>> getGlobalConfig();
  Future<void> saveGlobalConfig(List<GlobalConfig> configs);
  Future<List<GlobalConfig>?> getCachedGlobalConfig();
  Future<DateTime?> getConfigsCachedTimestamp();
  Future<void> clearGlobalConfig();
}
