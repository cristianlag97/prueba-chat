import 'package:chat_app/features/chat/domain/entities/chat_message_entity.dart';

import '../repos/chat_repository.dart';

class SendMessageUseCases {
  final ChatRepository repository;

  SendMessageUseCases(this.repository);

  Future<void> call(ChatMessageEntity message) async {
    return await repository.sendMessage(message);
  }
}
