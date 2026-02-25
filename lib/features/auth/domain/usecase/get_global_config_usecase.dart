import '../entity/global_config.dart';
import '../repository/global_config_repository.dart';

class GetGlobalConfigUseCase {
  final GlobalConfigRepository _repository;

  GetGlobalConfigUseCase(this._repository);

  Future<(List<GlobalConfig>?, String?)> call() async {
    try {
      final configs = await _repository.getGlobalConfig();
      return (configs, null);
    } catch (e) {
      return (null, e.toString());
    }
  }
}
