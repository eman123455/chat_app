import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessages);
  void sendMessage({required String message, required String email}) {
    try {
      messages
          .add({kMesaage: message, kCreatedAt: DateTime.now(), 'id': email});
    } on Exception catch (e) {
      emit(ChatFailure(errMsg: e.toString()));
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for (var message in event.docs) {
        messagesList.add(Message.fromJson(message));
      }
      emit(ChatSucess(messages: messagesList));
    });
  }
}
