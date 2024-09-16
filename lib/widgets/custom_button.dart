import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key,required this.text,required this.onTap});
  final String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        )),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xff415160),
                fontSize: 20,
              ),
            ),
          ),
        ));
  }
}
