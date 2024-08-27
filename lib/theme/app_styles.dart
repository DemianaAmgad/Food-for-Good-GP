import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final TextStyle titleStyle = GoogleFonts.rubik(
    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  );
  static final TextStyle fieldStyle = GoogleFonts.rubik(
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
  );
  static final TextStyle subtitleStyle = GoogleFonts.rubik(
    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
  );
  static final TextStyle normalStyle = GoogleFonts.rubik(
    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
  );
  static final TextStyle buttonTextStyle = GoogleFonts.rubik(
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );
  static final TextStyle cardTitleStyle = GoogleFonts.rubik(
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  );
  static final TextStyle cardButtonTextStyle = GoogleFonts.rubik(
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  );
}

class AppColors {
  static const titleColor = Colors.white;
  static const subtitleColor = Colors.white12;
  static const hintTextColor = Colors.white70;
  static const loginColor = Colors.black38;
  static const signupColor = Colors.black38;
  static const buttonBackgroundColor = Colors.white;
  static const buttonTextColor = Colors.teal;
  static const buttonLoginBackgroundColor = Colors.teal;
  static const buttonLoginTextColor = Colors.white;
  static const forgetPasswordColor = Colors.lightBlueAccent;
  static const doYouHaveAccountColor = Colors.white54;
  static const selectedItemColor = Colors.white70;
  static const unselectedItemColor = Colors.black;
  static const confirmButtonTextColor = Colors.white;
  static const confirmButtonBackgroundColor = Colors.teal;
  static const cardBackgroundColor = Colors.black;
  static const cardTitleColor = Colors.white;
  static const buttonAcceptBackgroundColor = Colors.teal;
  static const buttonRejectBackgroundColor = Colors.pink;
  static const cardTextColor = Colors.white70;
  static const iconColor = Colors.grey;
}