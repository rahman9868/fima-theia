import 'dart:convert';
import 'package:http/http.dart' as http;

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
  final String baseUrl;

  ApiClient(this.baseUrl);

  bool get _isDebugMode {
    var debug = false;
    assert(debug = true);
    return debug;
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse(baseUrl + endpoint);
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
      if (errorBody.containsKey('error_description')) {
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
  }) async {
    final url = Uri.parse(baseUrl + endpoint);
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
      if (errorBody.containsKey('error_description')) {
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
