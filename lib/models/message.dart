import 'package:chat_app/constants.dart';

class Message {
  final String message;
  final String id;
  Message({required this.id,required this.message});

  factory Message.fromJson(json) {
    return Message(message: json[kMesaage],id:json['id']);
  }
}
