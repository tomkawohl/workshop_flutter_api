library what_do_i_like_theme;

import 'package:flutter/material.dart';

class ColorWhatDoILike {
  static const Color main = Colors.blue;
  static const Color secondary = Colors.blueAccent;
  static const Color background = Colors.white;

  static const Color darkMain = Colors.white;
  static const Color darkSecondary = Colors.white70;
  static const Color darkBackground = Colors.black;
}

class WhatDoILikeTheme {
  static ThemeData get light => ThemeData(
        colorScheme: const ColorScheme.light(
          primary: ColorWhatDoILike.main,
          secondary: ColorWhatDoILike.secondary,
          background: ColorWhatDoILike.background,
        ),
        brightness: Brightness.light,
      );

  static ThemeData get dark => ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: ColorWhatDoILike.darkMain,
          secondary: ColorWhatDoILike.darkSecondary,
          background: ColorWhatDoILike.darkBackground,
        ),
        brightness: Brightness.dark,
      );
}
