part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class Register extends RegisterEvent {
  final String nickname;
  final String phone;
  final String email;
  final String password;

  Register({
    required this.email,
    required this.nickname,
    required this.password,
    required this.phone,
  });
}
