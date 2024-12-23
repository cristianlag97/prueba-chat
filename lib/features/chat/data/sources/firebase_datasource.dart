import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/chat_message_model.dart';

class FirebaseChatDataSource {
  final FirebaseFirestore firestore;

  FirebaseChatDataSource(this.firestore);

  Future<void> sendMessage(ChatMessageModel message) async {
    await firestore.collection('messages').add(message.toJson());
  }

  Future<void> sendAudioMessage(String filePath, String userId) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef =
        FirebaseStorage.instance.ref().child('audios/$fileName.aac');

    await storageRef.putFile(File(filePath));

    final audioUrl = await storageRef.getDownloadURL();

    await firestore.collection('messages').add({
      'type': 'audio',
      'url': audioUrl,
      'text': null,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': userId
    });
  }

  Stream<List<ChatMessageModel>> getMessages() {
    try {
      return firestore
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          var timestamp = doc['timestamp'];

          if (timestamp is int) {
            timestamp = DateTime.fromMillisecondsSinceEpoch(timestamp);
          }

          return ChatMessageModel.fromJson({
            ...doc.data(),
            'timestamp': timestamp,
          });
        }).toList();
      });
    } catch (e) {
      print('Error al obtener los mensajes: $e');
      throw Exception('Error al obtener los mensajes: $e');
    }
  }
}
