import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:read_me/controllers/tts_player_controller.dart';
import 'package:read_me/models/tts_player_state.dart';
import 'package:read_me/providers/read_text_provider.dart';
import 'package:unicons/unicons.dart';

final textProvider = StateProvider<String>((ref) {
  return "";
});

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final controller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "ReadMe",
          style: GoogleFonts.questrial(
            fontSize: 28,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final playerState =
                      ref.watch(ttsPlayerControllerProvider).value;
                  return ElevatedButton.icon(
                    onPressed: () async {
                      if (playerState == TtsPlayerState.playing) {
                        await ref
                            .read(ttsPlayerControllerProvider.notifier)
                            .pause();
                        return;
                      }
                      if (playerState != TtsPlayerState.paused &&
                          playerState == TtsPlayerState.idle) {
                        await ref
                            .read(ttsPlayerControllerProvider.notifier)
                            .play();
                      } else {
                        await ref
                            .read(ttsPlayerControllerProvider.notifier)
                            .resume();
                      }
                    },
                    icon: playerState == TtsPlayerState.playing
                        ? const Icon(
                            UniconsLine.pause,
                          )
                        : const Icon(
                            UniconsLine.play,
                          ),
                    label: playerState == TtsPlayerState.playing
                        ? const Text("Pause")
                        : playerState == TtsPlayerState.paused
                            ? const Text("Resume")
                            : const Text("Play"),
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.all(16),
                      ),
                    ),
                  );
                },
              ),

              const Gap(16),
              ElevatedButton.icon(
                onPressed: () async {
                  await ref.read(ttsPlayerControllerProvider.notifier).stop();
                },
                icon: const Icon(
                  UniconsLine.square_shape,
                ),
                label: const Text("Stop"),
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.all(16),
                  ),
                ),
              ),
              const Gap(16),
              // const ProgressSlider(),
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 8),
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: HookConsumer(
                        builder: (context, ref, _) {
                          final playerState =
                              ref.watch(ttsPlayerControllerProvider).value;
                          final toShow =
                              playerState == TtsPlayerState.playing ||
                                  playerState == TtsPlayerState.paused;

                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: toShow
                                ? Align(
                                    alignment: Alignment.topLeft,
                                    child: Consumer(
                                      builder: (context, ref, _) {
                                        final text =
                                            ref.watch(readTextProvider);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              text,
                                              textAlign: TextAlign.justify,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : TextField(
                                    controller: controller,
                                    onChanged: (value) {
                                      ref.read(textProvider.notifier).state =
                                          controller.text;
                                    },
                                    maxLines: null,
                                    minLines: null,
                                    expands: true,
                                    textAlign: TextAlign.justify,
                                    decoration: const InputDecoration(
                                      hintText: "Start typing here...",
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

