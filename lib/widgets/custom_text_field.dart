import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, required this.hinttext, required this.onChange,required this.isPasswordField, this.obscureText=false});
  final String hinttext;
  Function(String)? onChange;
    bool isPasswordField;
  final RegExp emailRegex = RegExp(
    r'^[^@]+@[^@]+\.[^@]+',
  );
  final bool   obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        if (isPasswordField) {
          if (data.length < 6) {
            return 'Password must be at least 6 characters long';
          } }
        else {
          if (!emailRegex.hasMatch(data)) {
            return 'Enter a valid email that contain @ and domain name ';
          }
        }
        },

  
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.white)),
      ),
    );
  }
}
