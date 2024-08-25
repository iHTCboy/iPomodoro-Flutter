import 'package:audioplayers/audioplayers.dart';

// https://pub.dev/packages/audioplayers/example
class AudioPlayerUtil {
  static AudioPlayer player = AudioPlayer();
  AudioPlayer audioPlayer = AudioPlayer();
  final AudioContext audioContext = AudioContext(
    iOS: AudioContextIOS(
      category: AVAudioSessionCategory.playback,
      options: [
        AVAudioSessionOptions.defaultToSpeaker,
        AVAudioSessionOptions.allowAirPlay,
        AVAudioSessionOptions.allowBluetooth,
        AVAudioSessionOptions.allowBluetoothA2DP,
        AVAudioSessionOptions.mixWithOthers,
      ],
    ),
    android: AudioContextAndroid(
      isSpeakerphoneOn: true,
      stayAwake: true,
      contentType: AndroidContentType.music,
      usageType: AndroidUsageType.media,
      audioFocus: AndroidAudioFocus.gain,
    ),
  );

  static playAudio(url) {
    if (url == null) {
      return player.resume();
    } else {
      return player.play(AssetSource(url));
    }
  }

  static stopAudio() {
    return player.stop();
  }
  setCache(url) {
    AudioPlayer.global.setGlobalAudioContext(audioContext);
    audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    return audioPlayer.setSource(AssetSource(url));
  }

  play(url) {
    if (url == null) {
      if (audioPlayer.state == PlayerState.playing) {
        return;
      }
      return audioPlayer.resume();
    } else {
      return audioPlayer.play(AssetSource(url));
    }
  }

  seek(duration) {
    return audioPlayer.seek(duration);
  }

  loop(bool isLoop) {
    audioPlayer.setReleaseMode(isLoop ? ReleaseMode.loop : ReleaseMode.stop);
  }

  stop() {
    return audioPlayer.stop();
  }

  pause() {
    return audioPlayer.pause();
  }

  release() {
    return audioPlayer.release();
  }

}