part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class SignUpSuccess extends AuthState {
  final UserModel user;

  SignUpSuccess(this.user);
}

final class SignUpFailure extends AuthState {
  final String message;

  SignUpFailure(this.message);
}

final class SignInSuccess extends AuthState {
  final UserModel user;

  SignInSuccess(this.user);
}

final class SignInFailure extends AuthState {
  final String message;

  SignInFailure(this.message);
}
