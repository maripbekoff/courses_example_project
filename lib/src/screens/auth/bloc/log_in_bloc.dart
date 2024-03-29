import 'package:bloc/bloc.dart';
import 'package:courses_example_project/src/common/models/remote/auth_model.dart';
import 'package:courses_example_project/src/common/models/remote/user_model.dart';
import 'package:courses_example_project/src/services/auth/authorization_service.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final Box tokensBox = Hive.box('tokens');
  final Box<UserModel> userBox = Hive.box('user');

  final AuthorizationService authorizationService;

  LogInBloc({
    required this.authorizationService,
  }) : super(LogInInitial()) {
    on<LogInPressed>((event, emit) async {
      emit(LogInLoading());

      try {
        AuthModel authModel = await authorizationService.logIn(
          email: event.email.trim(),
          password: event.password.trim(),
        );

        tokensBox.put('access', authModel.tokens.access);
        tokensBox.put('refresh', authModel.tokens.refresh);
        userBox.put('user', authModel.user);

        emit(LogInLoaded());
      } on DioError catch (e) {
        emit(LogInFailed(message: 'Неправильный логин или пароль'));
        throw e;
      } catch (e) {
        emit(LogInFailed(message: 'Произошла ошибка'));
        throw e;
      }
    });
  }
}
