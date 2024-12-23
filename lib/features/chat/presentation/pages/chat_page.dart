import 'dart:developer';

import 'package:chat_app/core/plugins/storage/key_value_storage_service_impl.dart';
import 'package:chat_app/features/chat/presentation/providers/chat_providers.dart';
import 'package:chat_app/features/chat/presentation/widgets/appbar.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_audio.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_message.dart';
import 'package:chat_app/features/chat/presentation/widgets/input_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late String userId = '';
  late Future<String?> userIdFuture;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    String? savedUserId =
        await KeyValueStorageServiceImpl.instance.getValue<String>('userId');

    if (savedUserId == null) {
      savedUserId = 'user-${const Uuid().v4()}';
      await KeyValueStorageServiceImpl.instance
          .setKeyValue<String>('userId', savedUserId);
    }

    userId = savedUserId;

    log('User ID: $userId');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarChat(),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final messagesStream = ref.watch(messagesProvider);

                return messagesStream.when(
                  data: (messages) => ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];

                      if (message.type == 'text' &&
                          message.text != null &&
                          message.text!.isNotEmpty) {
                        return ChatMessage(
                          text: message.text!,
                          id: userId,
                          currentUserId: message.userId,
                          animationController: AnimationController(
                            vsync: this,
                            duration: const Duration(milliseconds: 300),
                          )..forward(),
                        );
                      } else if (message.type == 'audio' &&
                          message.audioUrl != null &&
                          message.audioUrl!.isNotEmpty) {
                        return ChatAudio(
                          audioUrl: message.audioUrl!,
                          id: userId,
                          currentUserId: message.userId,
                        );
                      } else {
                        return const ListTile(
                          title: Text('Mensaje no disponible'),
                        );
                      }
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Text('Error: $err'),
                );
              },
            ),
          ),
          const Divider(
            height: 5,
            color: Colors.black87,
          ),
          Container(
            color: Colors.white,
            child: InputChat(userId: userId),
          )
        ],
      ),
    );
  }
}
