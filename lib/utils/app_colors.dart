import 'package:flutter/material.dart';

class AppColors {
  static const Gradient orangeGradient = LinearGradient(
    colors: [darkOrange, lightYellow],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient radialGradientBlue = RadialGradient(
    colors: [
      Color(0xff2889EB),
      Color(0xff0B56CB),
    ],
    radius: 5,
  );

  static const Gradient redGradient = LinearGradient(
    colors: [Color(0xffEF1F28), Color(0xffAD0007)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const Gradient lightBlackGradient = LinearGradient(
    colors: [darkGrey, darkGrey],
  );
  static Gradient whiteBlackGradient = LinearGradient(
    colors: [Colors.black12.withOpacity(.001), white.withOpacity(0.1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient blackGradient = LinearGradient(
    colors: [Color(0xff495B7E), Color(0xff324262)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient redPinkGradient = LinearGradient(
    colors: [Color(0xffef5b78), Color(0xffce2f4f)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient lightOrangeGradient = LinearGradient(
    colors: [Color(0xffFF8A1C), Color(0xffFFC731)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient peachGradient = LinearGradient(
    colors: [Color(0xffFF5D6E), Color(0xffFF8D45)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient blueGradient = LinearGradient(
    colors: [
      Color(0xff0454FF),
      Color(0xff0B7ED7),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient greenGradient = LinearGradient(
    colors: [Color(0xff5C9602), Color(0xff8DC900)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient purpleGradient = LinearGradient(
    colors: [Color(0xff9962DE), Color(0xff948DFF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient cyanGradient = LinearGradient(
    colors: [Color(0xff00D5AA), Color(0xff3A9F9F)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color darkOrange = Color(0xffff715d);
  static const Color lightYellow = Color(0xffffa124);
  static const Color lightOrange = Color(0xffFC885B);
  static const Color lightPink = Color(0xffFC5F70);
  static const Color darkThemeBackground = Color(0xff1A1A36);
  static const Color darkThemeCardColor = Color(0xff15152D);
  static const Color quizBackground = Color(0xff934060);
  static const Color red = Color(0xffEF1F28);
  static const Color orangeAccent = Color(0xffFF8D45);
  static const Color yellow = Color(0xffFAC417);
  static const Color white = Color(0xffFFFFFF);
  static const Color backgroundGrey = Color(0xffF5F7FB);
  static const Color greyText = Color(0xffB9B9B9);
  static const Color blackGrey = Color(0xff6F6F79);
  static const Color darkGrey = Color(0xff707070);
  static const Color whitishGrey = Color(0xff666E7A);
  static const Color blueishGrey = Color(0xff475A81);
  static const Color lightGreen = Color(0xff86BE24);
  static const Color black = Color(0xff191B20);
  static const Color darkBlack = Color(0xff040404);
  static const Color blue = Color(0xff1DA1F2);
  static const Color darkBlue = Color(0xff0454FF);
  static const Color purpleBlue = Color(0xff9583F2);
  static const Color purple = Color(0xff6A5AE0);
  static const Color aqua = Color(0xff24C7A7);
  static const Color transparent = Colors.transparent;
  static const Color scaffoldColor = Color(0xffF8FAFB);
  static const Color checkBoxColor = Color(0xff68CAD7);

  static const Color khaltiPurpleColor = Color(0xff5C2D91);
}
