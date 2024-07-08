import 'package:flutter/material.dart';

class AppColors {
  static Color splashColor = Color(0xff020f4d);
  static Color whiteColor = Color(0xffffffff);
  static Color gradiantFirstColor = Color(0xffd23156);
  static Color gradiantSecondColor = Color(0xff13d0c1);
  static Color blackColor = Color(0xff101011);
  static Color greyColor = Color(0xffbebaba);
  static Color cardColor = Color(0xff9ca5d7);
  static Color cardSecondColor = Color(0xFFE0F7FA);

  static List<Color> primaryColors = const [
    Color(0xffd23156),
    Color(0xff16b9fd),
    Color(0xff13d0c1),
    Color(0xffe5672f),
    Color(0xffb73d99),
    Color(0xff020f4d),
    Color(0xff488fcb),
    Color(0xff15ef0e),
    Color(0xffbebaba),
    Color(0xffffffff),
    Color(0xff101011),
    Color(0xffde1a31),
    Color(0xff024d14),
  ];

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> _colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color,
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, _colorShades);
  }
}
