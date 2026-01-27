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
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('--> ${options.method} ${options.baseUrl}${options.path}');
          print('Headers: ${options.headers}');
          print('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('<-- ${response.statusCode} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
          print('Response: ${response.data}');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          print('Error: ${e.message}');
          if (e.response != null) {
            print('Error response: ${e.response?.data}');
          }
          return handler.next(e);
        },
      ),
    );
  }
  final Dio _dio = Dio();

  Dio get client => _dio;
}
