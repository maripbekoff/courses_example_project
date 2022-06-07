import 'package:bloc/bloc.dart';
import 'package:courses_example_project/src/common/models/remote/auth_model.dart';
import 'package:courses_example_project/src/common/models/remote/user_model.dart';
import 'package:courses_example_project/src/services/auth/authorization_service.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Box tokensBox = Hive.box('tokens');
  final Box<UserModel> userBox = Hive.box('user');

  final AuthorizationService authorizationService;

  RegisterBloc({
    required this.authorizationService,
  }) : super(RegisterInitial()) {
    on<Register>((event, emit) async {
      emit(RegisterLoading());

      try {
        AuthModel authModel = await authorizationService.register(
          email: event.email,
          nickname: event.nickname,
          phone: event.phone,
          password: event.password,
        );

        tokensBox.put('access', authModel.tokens.access);
        tokensBox.put('refresh', authModel.tokens.refresh);
        userBox.put('user', authModel.user);

        emit(RegisterLoaded());
      } on DioError catch (e) {
        emit(RegisterFailed(message: 'Произошла ошибка'));
        throw e;
      } catch (e) {
        emit(RegisterFailed(message: 'Произошла ошибка'));
        throw e;
      }
    });
  }
}
