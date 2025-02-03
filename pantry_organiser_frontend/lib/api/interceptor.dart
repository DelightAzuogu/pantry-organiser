import 'dart:async';

import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract {
  AuthInterceptor(this.token);

  final String token;

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    request.headers['Authorization'] = 'Bearer $token';
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}
