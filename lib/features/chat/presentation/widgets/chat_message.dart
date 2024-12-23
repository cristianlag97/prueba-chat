import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String id;
  final String currentUserId;
  final AnimationController animationController;

  const ChatMessage({
    super.key,
    required this.text,
    required this.id,
    required this.currentUserId,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: id == currentUserId
              ? MyMessage(text: text)
              : NotMyMessage(text: text),
        ),
      ),
    );
  }
}

class MyMessage extends StatelessWidget {
  final String text;

  const MyMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 5),
        decoration: BoxDecoration(
            color: const Color(0xff4D9EF6),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class NotMyMessage extends StatelessWidget {
  final String text;

  const NotMyMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 5, right: 50),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 232, 229, 228),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
