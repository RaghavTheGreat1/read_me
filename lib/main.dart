import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:read_me/screens/home_screen.dart';
import 'package:read_me/themes/light_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyReadMeApp(),
    ),
  );
}

class MyReadMeApp extends StatelessWidget {
  const MyReadMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
