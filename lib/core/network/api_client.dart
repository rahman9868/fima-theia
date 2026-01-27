import 'dart:convert';
import 'dart:developer' as developer;
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

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse(baseUrl + endpoint);
    developer.log('Request URL: $url', name: 'my_app.network');
    developer.log('Request Headers: $headers', name: 'my_app.network');

    final response = await http.get(url, headers: headers);

    developer.log(
      'Response Status Code: ${response.statusCode}',
      name: 'my_app.network',
    );
    developer.log('Response Body: ${response.body}', name: 'my_app.network');

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
    developer.log('Request URL: $url', name: 'my_app.network');
    developer.log('Request Headers: $headers', name: 'my_app.network');
    developer.log('Request Body: $body', name: 'my_app.network');

    final response = await http.post(url, headers: headers, body: body);

    developer.log(
      'Response Status Code: ${response.statusCode}',
      name: 'my_app.network',
    );
    developer.log('Response Body: ${response.body}', name: 'my_app.network');

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
