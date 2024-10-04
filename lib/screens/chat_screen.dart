import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  static String id = 'ChatScreen';

  List<Message> messagesList = [];

  TextEditingController controller = TextEditingController();

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLog,
              height: 50,
              width: 50,
            ),
            const Text(
              'Chat',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSucess) {
                  messagesList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(message: messagesList[index])
                          : ChatBubbleForFriends(message: messagesList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: value, email: email!);
                controller.clear();
                _controller.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceInOut);
              },
              decoration: InputDecoration(
                  hintText: 'Send Message ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: kPrimaryColor,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: kPrimaryColor,
                      )),
                  suffixIcon: GestureDetector(
                    child: const Icon(
                      Icons.send,
                      color: kPrimaryColor,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
