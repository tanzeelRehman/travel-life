import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  AppColors._();

  static HexColor primary = HexColor("#4E1592");
  static HexColor secondary = HexColor("#a06fdb");

  static HexColor grey = HexColor("#949494");
  static HexColor lightGrey = HexColor("#D9D9D9");
  static HexColor darkGrey = HexColor("#474747");
  static HexColor black = HexColor("#000000");
  static HexColor white = HexColor("#ffffff");
  static HexColor peach = HexColor("#FCEFDA");
  static HexColor yellow = HexColor("#FFDB45");
  static HexColor purple = HexColor("#743FA9");
  static HexColor green = HexColor("#41BD6F");
  static HexColor red = HexColor("#BD0000");

  static HexColor appDarkBlue = HexColor("#04012C");
  static HexColor appFaddedBlue = HexColor("#323B4F");
  static HexColor appSkyBlue = HexColor("#3C9FEB");

  static Gradient mainButtonGradient = LinearGradient(
    colors: [
      HexColor("#34C8E8"),
      HexColor("#4E4AF2"),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Gradient secondaryButtonGradient = LinearGradient(
    colors: [
      HexColor("#202545"),
      HexColor("#1D2138"),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static List<BoxShadow> appNameBoxShadows = [
    BoxShadow(
      offset: Offset(4, 4),
      blurRadius: 10,
      color: HexColor("#000000").withOpacity(0.30),
    ),
    BoxShadow(
      offset: Offset(-4, -4),
      blurRadius: 10,
      color: HexColor("#D3D3D3").withOpacity(0.15),
    ),
  ];
}
