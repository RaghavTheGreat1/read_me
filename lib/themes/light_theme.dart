import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_me/themes/custom_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: CustomColors.yellow,
    appBarTheme: const AppBarTheme(
      color: CustomColors.yellow,
      surfaceTintColor: CustomColors.yellow,
    ),
    textTheme: GoogleFonts.mavenProTextTheme(),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Colors.black,
        ),
        foregroundColor: MaterialStatePropertyAll(
          CustomColors.yellow,
        ),
      ),
    ),
  );
}
