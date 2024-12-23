import 'package:chat_app/core/plugins/just_audio_plugin.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ChatAudio extends StatefulWidget {
  const ChatAudio({
    super.key,
    required this.audioUrl,
    required this.id,
    required this.currentUserId,
  });

  final String audioUrl;
  final String id;
  final String currentUserId;

  @override
  State<ChatAudio> createState() => _ChatAudioState();
}

class _ChatAudioState extends State<ChatAudio> {
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _listenToPlayerState();
  }

  void _listenToPlayerState() {
    JustAudioPlugin.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  void _toggleAudioPlayback() async {
    if (_isPlaying) {
      JustAudioPlugin.stopAudio();
      setState(() {
        _isPlaying = false;
      });
    } else {
      try {
        setState(() {
          _isPlaying = true;
        });
        await JustAudioPlugin.playAudio(widget.audioUrl);
      } catch (e) {
        setState(() {
          _isPlaying = false;
        });
        print("Error reproduciendo audio: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.id != widget.currentUserId
        ? Row(
            children: [
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _toggleAudioPlayback,
              ),
              const Text('Audio message'),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Audio message'),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _toggleAudioPlayback,
              ),
            ],
          );
  }
}
