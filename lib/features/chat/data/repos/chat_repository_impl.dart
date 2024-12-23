import 'package:chat_app/features/chat/data/models/chat_message_model.dart';
import 'package:chat_app/features/chat/data/sources/firebase_datasource.dart';
import 'package:chat_app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:chat_app/features/chat/domain/repos/chat_repository.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseChatDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);

  @override
  Future<void> sendMessage(ChatMessageEntity message) {
    return dataSource.sendMessage(ChatMessageModel(
      id: message.id,
      text: message.text,
      userId: message.userId,
      type: message.type,
      audioUrl: message.audioUrl,
      timestamp: message.timestamp,
    ));
  }

  @override
  Future<void> sendAudioMessage(String filePath, String userId) async {
    return dataSource.sendAudioMessage(filePath, userId);
  }

  @override
  Stream<List<ChatMessageEntity>> getMessages() {
    return dataSource
        .getMessages()
        .map((models) => models.map((model) => model).toList());
  }

  // @override
  // Future<void> sendAudio(String audioPath, String userId) {
  //   return dataSource.sendAudio(audioPath, userId);
  // }
}
