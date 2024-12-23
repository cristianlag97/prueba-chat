import 'package:just_audio/just_audio.dart';

class JustAudioPlugin {
  JustAudioPlugin._();

  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playAudio(String audioUrl) async {
    try {
      await _audioPlayer.setUrl(audioUrl);
      _audioPlayer.play();
    } catch (e) {
      print("Error reproduciendo audio: $e");
    }
  }

  static Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print("Error deteniendo audio: $e");
    }
  }

  static Stream<PlayerState> get playerStateStream =>
      _audioPlayer.playerStateStream;
}
