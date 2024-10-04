import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
    if(event is LoginEvent){

    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: event.email, password: event.password);
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
    else if(event is RegisterEvent){
      emit(RegisterLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password:event.password,
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
    });
  }
}
