import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin:const  EdgeInsets.all(20),
        padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Text(
          message.message,
          style:const  TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}





class ChatBubbleForFriends extends StatelessWidget {
  const ChatBubbleForFriends({
    super.key,
    required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding:const  EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        decoration: const BoxDecoration(
            color: Color(0xff006488),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
