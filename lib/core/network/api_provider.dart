import 'package:dio/dio.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();
  factory ApiProvider() => _instance;
  ApiProvider._internal() {
    _dio.options = BaseOptions(
      baseUrl: 'https://wf.dev.neo-fusion.com/fira-api/',
      headers: {
        'Authorization': 'Basic ZmlyYS1hcGktY2xpZW50OnBsZWFzZS1jaGFuZ2UtdGhpcw',
      },
    );
  }
  final Dio _dio = Dio();

  Dio get client => _dio;
}