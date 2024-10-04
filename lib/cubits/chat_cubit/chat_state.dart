part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSucess extends ChatState {
  List<Message> messages;
  ChatSucess({required this.messages});
}

final class ChatFailure extends ChatState {
  final String errMsg;
  ChatFailure({required this.errMsg});
}
