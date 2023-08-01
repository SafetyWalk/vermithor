import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFFF8DEC3),
    200: const Color(0xFFF3C89C),
    300: const Color(0xFFEEB274),
    400: const Color(0xFFEAA256),
    500: const Color(0xFFE69138),
    600: const Color(0xFFE38932),
    700: const Color(0xFFDF7E2B),
    800: const Color(0xFFDB7424),
    900: const Color(0xFFD56217)
  };

  static const Color backgroundLight = Color.fromRGBO(235, 240, 243, 1);
  static const Color backgroundDark = Color.fromRGBO(32, 35, 41, 1);

  static const Color primaryLight = Color.fromRGBO(235, 240, 243, 1);
  static const Color primaryDark = Color.fromARGB(255, 77, 97, 163);

  static const Color primaryGradientDarkTopLeft = Color.fromRGBO(77, 97, 163, 1);
  static const Color primaryGradientDarkBottomRight =
      Color.fromRGBO(62, 53, 247, 1);

  static const Color containerLight = Color.fromRGBO(241, 245, 248, 1);
  static const Color containerDark = Color.fromRGBO(40, 50, 54, 1);

  static const Color containerPressedLight = Color.fromRGBO(232, 235, 241, 1);
  static const Color containerPressedDark = Color.fromRGBO(45, 50, 54, 1);

  static const Color containerShadowTopLight =
      Color.fromARGB(220, 255, 255, 255);
  static const Color containerShadowTopDark =
      Color.fromRGBO(255, 255, 255, 0.1);

  static const Color containerShadowBottomLight = Color.fromARGB(18, 0, 0, 0);
  static const Color containerShadowBottomDark = Color.fromRGBO(0, 0, 0, .3);

  static const Color containerInnerShadowTopLight =
      Color.fromRGBO(204, 206, 212, 1);
  static const Color containerInnerShadowTopDark = Color.fromRGBO(0, 0, 0, .9);

  static const Color containerInnerShadowBottomLight =
      Color.fromRGBO(255, 255, 255, 1);
  static const Color containerInnerShadowBottomDark =
      Color.fromRGBO(49, 54, 60, 1);

  static const Color primaryTextColorLight = Color.fromRGBO(53, 54, 59, 1);
  static const Color primaryTextColorDark = Color.fromRGBO(255, 255, 255, 1);

  static const Color secondaryTextColorLight =
      Color.fromRGBO(144, 149, 166, 1);
  static const Color secondaryTextColorDark = Color.fromRGBO(139, 144, 160, 1);

  static const Color iconLight = Color.fromRGBO(144, 149, 166, 1);
  static const Color iconDark = Color.fromRGBO(137, 142, 158, 1);
}
