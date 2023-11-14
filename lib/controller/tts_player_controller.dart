import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:read_me/models/tts_player_state.dart';
import 'package:read_me/screens/home_screen.dart';

final ttsPlayerControllerProvider =
    AsyncNotifierProvider<TtsPlayerControllerNotifier, TtsPlayerState>(
        TtsPlayerControllerNotifier.new);

class TtsPlayerControllerNotifier extends AsyncNotifier<TtsPlayerState> {
  final FlutterTts _flutterTts = FlutterTts();

  String get text {
    return ref.watch(textProvider);
  }

  @override
  TtsPlayerState build() {
    return TtsPlayerState.stopped;
  }

  Future<void> play() async {
    await _flutterTts.speak(text);
  }
}
