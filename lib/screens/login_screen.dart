import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String? email;

  String? password;

  GlobalKey<FormState> pKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSucessful) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatScreen.id,arguments:email );
          isLoading = false;
        } else {
          showSnackBar(context, 'There is an error ');
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: pKey,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    kLog,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child:  Text(
                      "Scholar Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'Pacifico'),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        isPasswordField: false,
                        onChange: (value) {
                          email = value;
                        },
                        hinttext: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          obscureText: true,
                          isPasswordField: true,
                          onChange: (value) {
                            password = value;
                          },
                          hinttext: 'Password'),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: 'LOGIN',
                        onTap: () async {
                          if (pKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .loginUSer(email: email!, password: password!);
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don't have an Account ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          child: const Text(
                            'REGISTER',
                            style: TextStyle(
                              color: Color(0xffC4E7E6),
                              fontSize: 15,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
