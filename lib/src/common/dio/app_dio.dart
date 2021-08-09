import 'dart:io';

import 'package:courses_example_project/src/common/models/remote/tokens_model.dart';
import 'package:courses_example_project/src/constants/const.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class AppDio {
  Dio dio = Dio(BaseOptions(
    baseUrl: api_url,
  ))
    ..interceptors.add(DioInterceptor());

  set path(String path) => dio = Dio(
        BaseOptions(baseUrl: api_url + path),
      )..interceptors.add(DioInterceptor());
}

class DioInterceptor extends Interceptor {
  Dio dio = Dio(BaseOptions(baseUrl: api_url));
  Box tokensBox = Hive.box('tokens');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.uri.path.contains('auth'))
      options.headers['Authorization'] = 'Bearer ${tokensBox.get('access')}';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if ((err.response?.statusCode ?? 0) == HttpStatus.unauthorized) {
      try {
        await refreshToken();
      } on DioError catch (e) {
        throw e.response!.data;
      }
    }
    super.onError(err, handler);
  }

  Future<void> refreshToken() async {
    Response response = await dio.post(
      'auth/login/refresh/',
      data: {
        'refreshToken': tokensBox.get('refresh').toString(),
      },
    );

    TokensModel tokens = TokensModel.fromJson(response.data['tokens']);

    await tokensBox.put('access', tokens.access);
    await tokensBox.put('refresh', tokens.refresh);
  }
}
