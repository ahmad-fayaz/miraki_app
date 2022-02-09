import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColorLight = Color(0XFFFFCA64);
  static const Color primaryColor = Color(0XFFFF9933);
  static const Color primaryColorDark = Color(0XFFC66A00);
  static const Color secondaryColorLight = Color(0XFF54B940);
  static const Color secondaryColor = Color(0XFF138808);
  static const Color secondaryColorDark = Color(0XFF005900);
  static const Color accentColor = Color(0XFF000080);
  static const Color light = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFA4A6B3);
  static const Color negativeColor = Colors.red;
  static const Color darkColor = Colors.black;
}

Map<int, Color> materialOrenge = {
  50: const Color.fromRGBO(255,153,51, .1),
  100: const Color.fromRGBO(255,153,51, .2),
  200: const Color.fromRGBO(255,153,51, .3),
  300: const Color.fromRGBO(255,153,51, .4),
  400: const Color.fromRGBO(255,153,51, .5),
  500: const Color.fromRGBO(255,153,51, .6),
  600: const Color.fromRGBO(255,153,51, .7),
  700: const Color.fromRGBO(255,153,51, .8),
  800: const Color.fromRGBO(255,153,51, .9),
  900: const Color.fromRGBO(255,153,51, 1),
};

MaterialColor materialPrimaryColor =
    MaterialColor(0XFFFF9933, materialOrenge);
