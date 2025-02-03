import 'package:http_interceptor/http_interceptor.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class ApiService {
  ApiService(this.token) {
    _client = InterceptedClient.build(
      interceptors: [AuthInterceptor(token)],
    );
  }

  static const String baseUrl =
      String.fromEnvironment('BASEURL', defaultValue: 'http://localhost:8080/api'); // Provide a default value

  final String token;
  late final InterceptedClient _client;

  // Helper method to build complete URL
  Uri _buildUrl(String endpoint) {
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    final cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    return Uri.parse('$cleanBaseUrl/$cleanEndpoint');
  }

  // Helper method to add default headers
  Map<String, String> _buildHeaders([Map<String, String>? headers]) {
    return {
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };
  }

  Future<Response> getData(String endpoint, {Map<String, dynamic>? queryParams, Map<String, String>? headers}) async {
    final uri = _buildUrl(endpoint);
    final finalUri = queryParams != null ? uri.replace(queryParameters: queryParams) : uri;

    return _client.get(finalUri, headers: _buildHeaders(headers));
  }

  Future<Response> post(String endpoint, dynamic body, {Map<String, String>? headers}) async {
    return _client.post(
      _buildUrl(endpoint),
      body: body,
      headers: _buildHeaders(headers),
    );
  }

  Future<Response> put(String endpoint, dynamic body, {Map<String, String>? headers}) async {
    return _client.put(
      _buildUrl(endpoint),
      body: body,
      headers: _buildHeaders(headers),
    );
  }

  Future<Response> delete(String endpoint, {Map<String, String>? headers}) async {
    return _client.delete(
      _buildUrl(endpoint),
      headers: _buildHeaders(headers),
    );
  }

  Future<Response> patch(String endpoint, dynamic body, {Map<String, String>? headers}) async {
    return _client.patch(
      _buildUrl(endpoint),
      body: body,
      headers: _buildHeaders(headers),
    );
  }
}
