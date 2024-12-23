import 'dart:io';

import 'package:chat_app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:chat_app/features/chat/presentation/providers/chat_providers.dart';
import 'package:chat_app/features/chat/presentation/widgets/audio_recorder_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputChat extends ConsumerStatefulWidget {
  const InputChat({super.key, required this.userId});
  final String userId;

  @override
  ConsumerState<InputChat> createState() => _InputChatState();
}

class _InputChatState extends ConsumerState<InputChat> {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isText = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                autocorrect: false,
                controller: textController,
                // onSubmitted: _handleSubmit,
                onChanged: (value) {
                  setState(() {
                    if (value.trim().isNotEmpty) {
                      isText = true;
                    } else {
                      isText = false;
                    }
                  });
                },
                decoration:
                    const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: focusNode,
              ),
            ),
            if (isText)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Platform.isIOS
                    ? CupertinoButton(
                        onPressed: isText
                            ? () => _handleSubmit(
                                textController.text, widget.userId)
                            : null,
                        child: const Text('Enviar'),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: IconTheme(
                          data: IconThemeData(color: Colors.blue[400]),
                          child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: const Icon(Icons.send_rounded),
                            onPressed: isText
                                ? () => _handleSubmit(
                                    textController.text, widget.userId)
                                : null,
                          ),
                        ),
                      ),
              )
            else
              AudioRecorderButton(userId: widget.userId),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text, String userId) {
    textController.clear();
    isText = false;
    setState(() {});
    if (text.trim().isEmpty) return;
    final sendMessage = ref.read(sendMessageUseCaseProvider);
    sendMessage(ChatMessageEntity(
      id: UniqueKey().toString(),
      text: text,
      userId: userId,
      type: 'text',
      timestamp: DateTime.now(),
    ));
  }
}
