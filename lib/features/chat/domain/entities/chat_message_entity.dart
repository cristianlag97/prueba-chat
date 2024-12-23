class ChatMessageEntity {
  final String id;
  final String? text; // Puede ser null si es un mensaje de audio
  final String? audioUrl; // URL del audio en Firebase Storage
  final String userId;
  final String type; // 'text' o 'audio';
  final DateTime timestamp;

  const ChatMessageEntity({
    required this.id,
    this.text,
    this.audioUrl,
    required this.userId,
    required this.type,
    required this.timestamp,
  });
}
