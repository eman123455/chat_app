part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSucessful extends RegisterState {}

final class RegisterFailure extends RegisterState {
  String errMsg;
  RegisterFailure({required this.errMsg});
}
