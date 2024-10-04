part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSucessful extends LoginState {}

final class LoginFailure extends LoginState {
  String errMsg;
  LoginFailure({required this.errMsg});
}

final class LoginLoading extends LoginState {}
