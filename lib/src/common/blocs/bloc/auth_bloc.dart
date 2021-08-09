import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Box tokensBox = Hive.box('tokens');

  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStart) {
      bool haveTokens =
          tokensBox.get('access') != null && tokensBox.get('refresh') != null;

      if (haveTokens) {
        yield Authenticated();
      } else {
        yield UnAuthenticated();
      }
    }
  }
}
