import '../entities/chat_message_entity.dart';

abstract class ChatRepository {
  Future<void> sendMessage(ChatMessageEntity message);
  Future<void> sendAudioMessage(String filePath, String userId);
  Stream<List<ChatMessageEntity>> getMessages();
}
