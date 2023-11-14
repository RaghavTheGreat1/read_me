import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:read_me/controller/tts_player_controller.dart';
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
          SizedBox(
            child: ElevatedButton.icon(
              onPressed: () async {
                await ref.read(ttsPlayerControllerProvider.notifier).play();
              },
              icon: const Icon(
                UniconsLine.play,
              ),
              label: const Text("Play"),
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.all(16),
                ),
              ),
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                width: (size.width / 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      ref.read(textProvider.notifier).state = controller.text;
                    },
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: "Start typing here...",
                      fillColor: Colors.white,
                      border: InputBorder.none,
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
