import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
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

  static HexColor appTextfieldBorderColor = HexColor("#3E3C52");

  static HexColor tripPlannerColor = HexColor("#805EF1");
  static HexColor vehicleRegistrationColor = HexColor("#35A7F2");
  static HexColor groupsColor = HexColor("#FE4BDC");
  static HexColor moneyManagerColor = HexColor("#FB9255");
  static HexColor chatsColor = HexColor("#527DFB");
  static HexColor eventMoneyManagerColor = HexColor("#20D256");

  static HexColor vehicleRegTextFieldBgColor = HexColor("#242C3B");

  static Gradient mainButtonGradient = LinearGradient(
    colors: [
      HexColor("#34C8E8"),
      HexColor("#4E4AF2"),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Gradient fabCloseButtonGradient = LinearGradient(
    colors: [
      HexColor("#222834"),
      HexColor("#090C2D"),
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

  //LOGOUT BUTTON BG GRADIENT
  static Gradient logoutButtonGradient = LinearGradient(
    colors: [
      HexColor("#FF9AA0"),
      HexColor("#E0A9A9"),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  //MAIN BUTTON BG GRADIENT
  static Gradient homeButtonGradient = LinearGradient(
    colors: [
      HexColor("#353F54").withOpacity(0.60),
      HexColor("#222834").withOpacity(0.60),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  //Buttons linear gradients
  static Gradient tripPlannerGradient = LinearGradient(
    colors: [
      HexColor("#B392F1"),
      HexColor("#7856F3"),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient vehicleRegistrationGradient = LinearGradient(
    colors: [
      HexColor("#94D8FD"),
      HexColor("#259FF1"),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient groupsGradient = LinearGradient(
    colors: [
      HexColor("#FF9AF1"),
      HexColor("#FF3FDA"),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient moneyManagerGradient = LinearGradient(
    colors: [
      HexColor("#FFC7A2"),
      HexColor("#FC8B49"),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient chatsGradient = LinearGradient(
    colors: [
      HexColor("#86ACFE"),
      HexColor("#4A77FE"),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient eventMoneyManagerGradient = LinearGradient(
    colors: [
      HexColor("#A8FFA8"),
      HexColor("#0BCD4A"),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
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

  static List<BoxShadow> homeScreenButtonIconsBoxShadows = [
    BoxShadow(
      offset: Offset(4, 4),
      blurRadius: 10,
      color: HexColor("#080727"),
    ),
    BoxShadow(
      offset: Offset(-4, -4),
      blurRadius: 10,
      color: HexColor("#FFFFFF").withOpacity(0.12),
    ),
  ];

  static List<BoxShadow> vehicleRegTextFieldBoxShadows = [
    BoxShadow(
      color: AppColors.vehicleRegTextFieldBgColor,
    ),
    BoxShadow(
      blurRadius: 30,
      color: HexColor("#191E29"),
      blurStyle: BlurStyle.inner,
    ),
  ];
  //! Groups
  static BoxDecoration groupCardsDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15.r),
      gradient: LinearGradient(colors: [
        Color(0xff363E51),
        Color(0xff4C5770),
      ]),
      border: GradientBoxBorder(
        gradient: LinearGradient(colors: [
          Color(0xffFFFFFF).withOpacity(.4),
          Color(0xff000000).withOpacity(.4)
        ]),
        width: .5,
      ));
  static BoxDecoration groupCardsDecoration2 = BoxDecoration(
      borderRadius: BorderRadius.circular(15.r),
      gradient: LinearGradient(colors: [
        Color(0xff353F54).withOpacity(.5),
        Color(0xff222834).withOpacity(.5),
      ]),
      border: GradientBoxBorder(
        gradient: LinearGradient(colors: [
          Color(0xffFFFFFF).withOpacity(.4),
          Color(0xff5A5A5A).withOpacity(.4),
          Color(0xffA8A8A8).withOpacity(.4)
        ]),
        width: .5,
      ));
  static GradientBoxBorder gradientBordersDecoration = GradientBoxBorder(
    gradient: LinearGradient(colors: [
      Color(0xffFFFFFF).withOpacity(.4),
      Color(0xff5A5A5A).withOpacity(.4),
      Color(0xffA8A8A8).withOpacity(.4)
    ]),
    width: 2,
  );
}
