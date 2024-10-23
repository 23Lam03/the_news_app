import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeCustom {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xffFFBA4B),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xffFFA100),
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xffFFBA4B),
        centerTitle: true,
        titleTextStyle: GoogleFonts.actor(
          fontWeight: FontWeight.w400,
          fontSize: 30,
          color: const Color(0xffFFFFFF),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.actor(
          fontWeight: FontWeight.w400,
          fontSize: 30,
          color: const Color(0xff000000),
        ),
        displayMedium: GoogleFonts.actor(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: const Color(0xffFFBD4A),
        ),
        bodyLarge: GoogleFonts.actor(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: const Color(0xff000000),
        ),
        bodyMedium: GoogleFonts.actor(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: const Color(0xff000000),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xffFEBB4B),
      ),
    );
  }
}
