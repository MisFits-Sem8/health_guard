import "package:flutter/material.dart";

class TColour {
  static Color get primaryColor1 => const Color(0xff845ec2);
  static Color get primaryColor2 => const Color(0xffB39CD0);
  static Color get secondaryColor1 => const Color(0xffFBEAFF);
  static Color get secondaryColor2 => const Color(0xff00C9A7);

  static List<Color> get primary => [primaryColor1, primaryColor2];
  static List<Color> get secondary => [black2,lightTextGray];
static List<Color> get gradient => [secondaryColor2, primaryColor1];

  static Color get black1 => const Color(0xff101617);
  static Color get black2 => Colors.black45;
  static Color get gray => const Color(0xff786f72);
  static Color get white => Colors.white;
  static Color get lightTextGray => const Color(0xFF8D8E98);
  static Color get lightGray => const Color(0xfff7f8f8);

}
