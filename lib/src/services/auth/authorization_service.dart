import 'package:courses_example_project/src/common/dio/app_dio.dart';
import 'package:courses_example_project/src/common/models/remote/auth_model.dart';
import 'package:courses_example_project/src/common/models/remote/tokens_model.dart';
import 'package:courses_example_project/src/common/models/remote/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthorizationService {
  Future<UserModel> getProfile();
  Future<AuthModel> logIn({required String email, required String password});
  Future<AuthModel> register({
    required String email,
    required String nickname,
    required String phone,
    required String password,
  });
  Future<TokensModel> refreshToken({required String refreshToken});
}

class AuthorizationServiceImpl implements AuthorizationService {
  late Dio dio;

  AuthorizationServiceImpl({required AppDio appDio}) {
    appDio.path = 'auth/';
    this.dio = appDio.dio;
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      Response response = await dio.get('login/profile');
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      throw e;
    }
  }

  @override
  Future<AuthModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.post('login', data: {
        'email': email,
        'password': password,
      });
      return AuthModel.fromJson(response.data);
    } on DioError catch (e) {
      throw e;
    }
  }

  @override
  Future<AuthModel> register({
    required String email,
    required String nickname,
    required String phone,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        'registration/customer/new',
        data: {
          'email': email,
          'nickname': nickname,
          'phone': phone,
          'password': password,
        },
      );
      return AuthModel.fromJson(response.data);
    } on DioError catch (e) {
      throw e;
    }
  }

  @override
  Future<TokensModel> refreshToken({required String refreshToken}) async {
    try {
      Response response = await dio.post('registration/customer/new', data: {
        'refresh_token': refreshToken,
      });
      return TokensModel.fromJson(response.data);
    } on DioError catch (e) {
      throw e;
    }
  }
}
