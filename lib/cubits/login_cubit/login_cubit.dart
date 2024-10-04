import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void loginUSer(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSucessful());
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMsg: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMsg: 'Wrong password'));
      }
        }
     catch (e) {
      emit(LoginFailure(errMsg: e.toString()));
    }
  }
}
