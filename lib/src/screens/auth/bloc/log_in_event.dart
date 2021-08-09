part of 'log_in_bloc.dart';

@immutable
abstract class LogInEvent {}

class LogInPressed extends LogInEvent {
  final String email;
  final String password;

  LogInPressed({
    required this.email,
    required this.password,
  });
}
