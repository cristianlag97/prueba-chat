import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required super.id,
    required super.text,
    required super.userId,
    required super.type,
    required super.audioUrl,
    required super.timestamp,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      text: json['text'],
      userId: json['userId'],
      audioUrl: json['url'],
      type: json['type'],
      timestamp: (json['timestamp'] is int)
          ? DateTime.fromMillisecondsSinceEpoch(json['timestamp'])
          : (json['timestamp'] is Timestamp)
              ? (json['timestamp'] as Timestamp).toDate()
              : (json['timestamp'] is DateTime)
                  ? json['timestamp'] as DateTime
                  : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'userId': userId,
      'audioUrl': audioUrl,
      'type': type,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
