import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';

class CustomColors{
  Color borderColor = const Color(0x69000E28);
  Color sidebarColor = const Color(0xFFF6A00C);
  Color backgroundStartColor = const Color(0xFF8400FF);
  Color backgroundEndColor = const Color(0xFF4737AF);
  Color backgroundSub = const Color(0xFF784DB0);
}

final buttonColors = WindowButtonColors(
  mouseOver: const Color(0xFF5145BE),
  mouseDown: const Color(0xFF483EAB),
  iconNormal: const Color(0xAAAAAAFF),
  iconMouseOver: const Color(0xFFFFFFFF),
);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xAAAAAAFF),
    iconMouseOver: const Color(0xFFFFFFFF)
);