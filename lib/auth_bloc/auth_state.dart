part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class LoginSucessful extends AuthState {}

final class LoginFailure extends AuthState {
  final String errMsg;
  LoginFailure({required this.errMsg});
}

final class LoginLoading extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSucessful extends AuthState {}

final class RegisterFailure extends AuthState {
final  String errMsg;
  RegisterFailure({required this.errMsg});
}