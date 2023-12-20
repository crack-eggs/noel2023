import 'package:just_audio/just_audio.dart';

import '../constants.dart';

class SoundService {
  static final SoundService _soundService = SoundService._internal();

  factory SoundService() => _soundService;

  SoundService._internal() {
    playSoundBackground();
  }

  final player = AudioPlayer();

  void playSoundBackground() async {
    if (!isWebMobile) {
      try {
        await player.setUrl('https://jmp.sh/s/H1CHOalqpMWg8HhaCKdA');
      } catch (e) {
        print('SoundService.playSoundBackground error: $e');
      }
      player.play();
    }
  }
}
