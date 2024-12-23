// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRepositoryHash() => r'ce90e984f114ddc52455ff09990e12b5b276a3f0';

/// See also [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider = AutoDisposeProvider<ChatRepository>.internal(
  chatRepository,
  name: r'chatRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatRepositoryRef = AutoDisposeProviderRef<ChatRepository>;
String _$sendMessageUseCaseHash() =>
    r'14a04f993e68bfdf3a8ba24f421bbf9f36543139';

/// See also [sendMessageUseCase].
@ProviderFor(sendMessageUseCase)
final sendMessageUseCaseProvider =
    AutoDisposeProvider<SendMessageUseCases>.internal(
  sendMessageUseCase,
  name: r'sendMessageUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendMessageUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SendMessageUseCaseRef = AutoDisposeProviderRef<SendMessageUseCases>;
String _$messagesHash() => r'b02cd15c82259f93251de33b4993ca86d43d6e6f';

/// See also [messages].
@ProviderFor(messages)
final messagesProvider =
    AutoDisposeStreamProvider<List<ChatMessageEntity>>.internal(
  messages,
  name: r'messagesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$messagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MessagesRef = AutoDisposeStreamProviderRef<List<ChatMessageEntity>>;
String _$sendAudioUsecaseHash() => r'2462ff397e8da90444cce3c4045fa44cdf0466d2';

/// See also [sendAudioUsecase].
@ProviderFor(sendAudioUsecase)
final sendAudioUsecaseProvider = AutoDisposeProvider<SendAudioUsecase>.internal(
  sendAudioUsecase,
  name: r'sendAudioUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendAudioUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SendAudioUsecaseRef = AutoDisposeProviderRef<SendAudioUsecase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
