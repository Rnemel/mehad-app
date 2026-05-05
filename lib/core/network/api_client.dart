class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException(statusCode: $statusCode, message: $message)';
}

abstract interface class ApiClient {
  Future<Map<String, dynamic>> getJson(String path);

  Future<Map<String, dynamic>> postJson(
    String path, {
    required Map<String, dynamic> body,
  });
}

class FakeApiClient implements ApiClient {
  @override
  Future<Map<String, dynamic>> getJson(String path) async => <String, dynamic>{};

  @override
  Future<Map<String, dynamic>> postJson(
    String path, {
    required Map<String, dynamic> body,
  }) async =>
      <String, dynamic>{};
}

