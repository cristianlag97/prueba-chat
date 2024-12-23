import 'dart:developer';

import 'package:chat_app/features/chat/presentation/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderButton extends ConsumerStatefulWidget {
  const AudioRecorderButton({super.key, required this.userId});
  final String userId;

  @override
  ConsumerState<AudioRecorderButton> createState() =>
      _AudioRecorderButtonState();
}

class _AudioRecorderButtonState extends ConsumerState<AudioRecorderButton> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool _isSending = false;
  String? _audioPath;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw Exception('Permiso de micrófono no concedido');
    }
    await _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final audioFilePath = '${tempDir.path}/audio.aac';

      await _recorder.startRecorder(toFile: audioFilePath);

      setState(() {
        _isRecording = true;
        _audioPath = audioFilePath;
      });
    } catch (e) {
      print("Error al iniciar la grabación: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      print("Error al detener la grabación: $e");
    }
  }

  Future<void> _sendAudio() async {
    if (_audioPath == null) return;
    setState(() {
      _isSending = true;
    });

    try {
      final sendAudio = ref.read(sendAudioUsecaseProvider);
      await sendAudio(_audioPath!, widget.userId);
    } catch (e) {
      print("Error al enviar el audio: $e");
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log('==Z> $_isSending');
    return GestureDetector(
      onPanDown: (_) async {
        await _startRecording();
      },
      onPanEnd: (_) async {
        if (_isRecording) {
          await _stopRecording();
          await _sendAudio();
        }
      },
      onPanCancel: () async {
        if (_isRecording) {
          await _stopRecording();
        }
      },
      child: _isSending
          ? const CircularProgressIndicator(
              color: Colors.blue,
            )
          : IconButton(
              icon: Icon(
                _isRecording ? Icons.stop : Icons.mic,
                color: Colors.blue,
              ),
              onPressed: null,
            ),
    );
  }
}
