import 'package:just_audio/just_audio.dart';

import '../constants.dart';

class SoundService {
  static final SoundService _soundService = SoundService._internal();

  factory SoundService() => _soundService;

  SoundService._internal() {
    playSoundBackground();
  }

  final webBackgroundPlayer = AudioPlayer();
  final receiveGiftPlayer = AudioPlayer();
  final tapPlayer = AudioPlayer();

  void playSoundBackground() async {
    if (!isWebMobile) {
      try {
        Future.wait([
          webBackgroundPlayer.setUrl(
              'https://otsv-xmas.netlify.app/sounds/web_background.mp3'),
          receiveGiftPlayer
              .setUrl('https://otsv-xmas.netlify.app/sounds/receive_gift.mp3'),
          tapPlayer.setUrl('https://otsv-xmas.netlify.app/sounds/tap.mp3'),
        ]);
      } catch (e) {
        print('SoundService.playSoundBackground error: $e');
      }
    }
  }
}
