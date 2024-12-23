import 'package:chat_app/features/chat/domain/repos/chat_repository.dart';

class SendAudioUsecase {
  final ChatRepository repository;

  SendAudioUsecase(this.repository);

  Future<void> call(String filePath, String userId) async {
    return await repository.sendAudioMessage(filePath, userId);
  }
}
