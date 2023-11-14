import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:read_me/models/tts_player_state.dart';
import 'package:read_me/providers/read_text_provider.dart';
import 'package:read_me/screens/home_screen.dart';

final ttsPlayerControllerProvider =
    AsyncNotifierProvider<TtsPlayerControllerNotifier, TtsPlayerState>(
        TtsPlayerControllerNotifier.new);

class TtsPlayerControllerNotifier extends AsyncNotifier<TtsPlayerState> {
  final FlutterTts _flutterTts = FlutterTts();

  int end = 1;

  String get readText {
    return ref.read(readTextProvider);
  }

  String get remainingText {
    return ref.read(textProvider).substring(
          end - 1,
        );
  }

  @override
  TtsPlayerState build() {
    return TtsPlayerState.idle;
  }

  Future<void> play() async {
    state = const AsyncValue.data(TtsPlayerState.playing);
    await _flutterTts.speak(remainingText);

    _flutterTts.setProgressHandler((text, start, end, word) {
      ref.read(readTextProvider.notifier).update((state) {
        String readText = "$state$word ";
        return readText;
      });
    });
  }

  Future<void> pause() async {
    state = const AsyncValue.data(TtsPlayerState.paused);
    end = ref.read(readTextProvider).length;
    await _flutterTts.stop();
  }

  Future<void> resume() async {
    state = const AsyncValue.data(TtsPlayerState.playing);

    await _flutterTts.speak(remainingText);

    _flutterTts.setProgressHandler((text, start, end, word) {
      ref.read(readTextProvider.notifier).update((state) {
        String readText = "$state$word ";
        return readText;
      });
    });
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    ref.read(readTextProvider.notifier).update((state) => "");

    end = 1;
    state = const AsyncValue.data(TtsPlayerState.idle);
  }
}
