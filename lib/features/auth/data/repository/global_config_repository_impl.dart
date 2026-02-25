import '../../domain/entity/global_config.dart';
import '../../domain/repository/global_config_repository.dart';
import '../model/global_config_dto.dart';
import '../source/global_config_data_source.dart';
import 'package:hive/hive.dart';

class GlobalConfigRepositoryImpl implements GlobalConfigRepository {
  final GlobalConfigDataSource _dataSource = GlobalConfigDataSource();
  static const _configBoxName = 'globalConfigBox';
  static const _configsKey = 'configs';
  static const _timestampKey = 'configs_timestamp';

  @override
  Future<List<GlobalConfig>> getGlobalConfig() async {
    try {
      final dtoList = await _dataSource.getGlobalConfig();
      final configList = dtoList
          .map(
            (dto) => GlobalConfig(
              code: dto.code,
              description: dto.description,
              id: dto.id,
              key: dto.key,
              value: dto.value,
            ),
          )
          .toList();

      // Cache the configs
      await saveGlobalConfig(configList);

      return configList;
    } catch (e) {
      print('[GlobalConfigRepository] Error fetching config: $e');
      // Return cached config on error
      final cached = await getCachedGlobalConfig();
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  @override
  Future<void> saveGlobalConfig(List<GlobalConfig> configs) async {
    try {
      final box = await Hive.openBox(_configBoxName);
      final now = DateTime.now();
      final timestamp = now.toIso8601String();

      // Convert to JSON-serializable format
      final configDtos = configs
          .map(
            (config) => {
              'code': config.code,
              'description': config.description,
              'id': config.id,
              'key': config.key,
              'value': config.value,
            },
          )
          .toList();

      await box.put(_configsKey, configDtos);
      await box.put(_timestampKey, timestamp);
      print('[GlobalConfigRepository] Configs saved to cache at $timestamp');
    } catch (e) {
      print('[GlobalConfigRepository] Error saving configs: $e');
    }
  }

  @override
  Future<List<GlobalConfig>?> getCachedGlobalConfig() async {
    try {
      final box = await Hive.openBox(_configBoxName);
      final configDtos = box.get(_configsKey) as List?;
      final timestamp = box.get(_timestampKey) as String?;

      if (configDtos != null && configDtos.isNotEmpty) {
        if (timestamp != null) {
          print(
            '[GlobalConfigRepository] Loaded cached configs from $timestamp',
          );
        }
        return configDtos.map((item) {
          final map = Map<String, dynamic>.from(item as Map);
          return GlobalConfig(
            code: map['code'] ?? '',
            description: map['description'] ?? '',
            id: map['id'] ?? 0,
            key: map['key'] ?? '',
            value: map['value'] ?? '',
          );
        }).toList();
      }
    } catch (e) {
      print('[GlobalConfigRepository] Error loading cached configs: $e');
    }
    return null;
  }

  /// Get the timestamp of when configs were last saved
  Future<DateTime?> getConfigsCachedTimestamp() async {
    try {
      final box = await Hive.openBox(_configBoxName);
      final timestamp = box.get(_timestampKey) as String?;
      if (timestamp != null) {
        return DateTime.parse(timestamp);
      }
    } catch (e) {
      print('[GlobalConfigRepository] Error getting timestamp: $e');
    }
    return null;
  }

  @override
  Future<void> clearGlobalConfig() async {
    try {
      final box = await Hive.openBox(_configBoxName);
      await box.delete('configs');
      print('[GlobalConfigRepository] Configs cleared');
    } catch (e) {
      print('[GlobalConfigRepository] Error clearing configs: $e');
    }
  }
}
