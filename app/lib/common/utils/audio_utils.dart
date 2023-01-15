import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

// https://pub.dev/packages/audioplayers/example
class AudioPlayerUtil {
  static AudioPlayer player = AudioPlayer();
  AudioPlayer audioPlayer = AudioPlayer();

  static playAudio(url) {
    if (url == null) {
      return player.resume();
    } else {
      return player.play(AssetSource(url));
    }
  }

  setCache(url) {
    audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    return audioPlayer.setSource(AssetSource(url));
  }

  play(url) {
    if (url == null) {
      return audioPlayer.resume();
    } else {
      return audioPlayer.play(AssetSource(url));
    }
  }

  seek(duration) {
    return audioPlayer.seek(duration);
  }

  stop() {
    return audioPlayer.stop();
  }


}