import 'package:chat_app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:chat_app/features/chat/domain/usecases/send_audio_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/repos/chat_repository_impl.dart';
import '../../data/sources/firebase_datasource.dart';
import '../../domain/repos/chat_repository.dart';
import '../../domain/usecases/send_message_usecase.dart';

part 'chat_providers.g.dart';

@riverpod
ChatRepository chatRepository(ChatRepositoryRef ref) {
  final firestore = FirebaseFirestore.instance;
  return ChatRepositoryImpl(FirebaseChatDataSource(firestore));
}

@riverpod
SendMessageUseCases sendMessageUseCase(SendMessageUseCaseRef ref) {
  return SendMessageUseCases(ref.watch(chatRepositoryProvider));
}

@riverpod
Stream<List<ChatMessageEntity>> messages(MessagesRef ref) {
  return ref.watch(chatRepositoryProvider).getMessages();
}

@riverpod
SendAudioUsecase sendAudioUsecase(SendAudioUsecaseRef ref) {
  return SendAudioUsecase(ref.watch(chatRepositoryProvider));
}
