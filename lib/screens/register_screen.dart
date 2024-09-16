import 'dart:ffi';


import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String id = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? password;

  String? emailAddress;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
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
                  child: Text(
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
                      'REGISTER',
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
                      onChange: (email) {
                        emailAddress = email;
                      },
                      hinttext: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      obscureText: true,
                        isPasswordField: true,
                        onChange: (pass) {
                          password = pass;
                        },
                        hinttext: 'Password'),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'REGISTER',
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await registerUser();
                              Navigator.pushNamed(context, ChatScreen.id,arguments: emailAddress);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(context, 'weak-password');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(context,
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            showSnackBar(context, e.toString());
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account ? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'LOGIN',
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
    );
  }

  Future<void> registerUser() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress!,
      password: password!,
    );

    credential.user?.sendEmailVerification();
    // await credential.user?.sendEmailVerification();
  }
}
