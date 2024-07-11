part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUp extends AuthEvent {
  final UserModel user;
  final String password;

  SignUp({required this.user, this.password = ''});
}

final class SignIn extends AuthEvent {
  final String email;
  final String password;

  SignIn({required this.email, required this.password});
}
