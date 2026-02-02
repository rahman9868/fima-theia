import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../services/token_provider.dart';

/// A custom exception for API errors.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException (Status $statusCode): $message';
    }
    return 'ApiException: $message';
  }
}

class ApiClient {
  final String baseUrl = "https://wf.dev.neo-fusion.com/fira-api/";
  final TokenProvider _tokenProvider = Get.find<TokenProvider>();

  ApiClient();

  bool get _isDebugMode {
    var debug = false;
    assert(debug = true);
    return debug;
  }

  Future<Map<String, String>> _injectAuthHeaders(
    Map<String, String>? headers,
  ) async {
    headers ??= {};
    final accessToken = await _tokenProvider.getAccessToken();
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse(baseUrl + endpoint);
    headers = await _injectAuthHeaders(headers);
    if (_isDebugMode) {
      print('[API][GET] $url');
      print('[API][HEADERS] $headers');
    }
    final response = await http.get(url, headers: headers);
    if (_isDebugMode) {
      print('[API][STATUS] ${response.statusCode}');
      print('[API][BODY] ${response.body}');
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      final errorBody = json.decode(response.body);
      if (errorBody is Map && errorBody.containsKey('error_description')) {
        throw ApiException(
          errorBody['error_description'],
          statusCode: response.statusCode,
        );
      } else {
        throw ApiException(
          'An unexpected error occurred',
          statusCode: response.statusCode,
        );
      }
    }
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    bool requireAuth = true,
  }) async {
    final url = Uri.parse(baseUrl + endpoint);
    if (requireAuth) {
      headers = await _injectAuthHeaders(headers);
    }
    if (_isDebugMode) {
      print('[API][POST] $url');
      print('[API][HEADERS] $headers');
      print('[API][BODY] $body');
    }
    final response = await http.post(url, headers: headers, body: body);
    if (_isDebugMode) {
      print('[API][STATUS] ${response.statusCode}');
      print('[API][BODY] ${response.body}');
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      final errorBody = json.decode(response.body);
      if (errorBody is Map && errorBody.containsKey('error_description')) {
        throw ApiException(
          errorBody['error_description'],
          statusCode: response.statusCode,
        );
      } else {
        throw ApiException(
          'An unexpected error occurred',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
