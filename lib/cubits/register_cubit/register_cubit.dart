import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser(
      {required String emailAddress, required String password}) async {
    emit(RegisterLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      credential.user?.sendEmailVerification();
      emit(RegisterSucessful());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMsg: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errMsg: 'email-already-in-use'));
      }
    } on Exception catch (e) {
      emit(RegisterFailure(errMsg: e.toString()));
    }
  }
}
