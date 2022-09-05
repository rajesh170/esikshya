import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esikshya/utils/app_colors.dart';

enum TextStyles {
  size50_400,
  size44_900,
  size40_900,
  size36_700,
  size32_800,
  size32_700,
  size32_600,
  size32_400,
  size28_800,
  size28_700,
  size24_700,
  size24_600,
  size24_400,
  size22_700,
  size20_400,
  size20_600,
  size18_700,
  size18_600,
  size18_500,
  size18_400,
  size17_600,
  size16_600,
  size16_500,
  size16_400,
  size16_700,
  size15_700,
  size15_600,
  size15_400,
  size15_300,
  size14_700,
  size14_600,
  size14_500,
  size14_400,
  size14_300,
  size12_700,
  size12_600,
  size12_500,
  size12_400,
  size10_400,
  size10_500,
  size10_600,
  size8_400,
}

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  final String text;
  final TextStyles styles;
  final FontStyle fontStyle;
  final TextAlign textAlign;
  final int maxLines;
  double fontSize;
  Color color;
  FontWeight fontWeight;
  String font;
  TextOverflow textOverflow;
  TextDecoration decoration;
  double letterSpacing;
  final double fontSizeDefault = 14.sp;

  TextWidget(this.text,
      {Key? key,
      this.styles = TextStyles.size14_400,
      this.fontStyle = FontStyle.normal,
      this.textAlign = TextAlign.start,
      this.maxLines = 1,
      this.fontSize = 15,
      this.color = AppColors.black,
      this.fontWeight = FontWeight.normal,
      this.font = "Montserrat",
      this.textOverflow = TextOverflow.ellipsis,
      this.letterSpacing = -0.02,
      this.decoration = TextDecoration.none})
      : super(key: key) {
    getStyle();
  }

  getStyle() {
    switch (styles) {
      case TextStyles.size50_400:
        {
          fontWeight = FontWeight.w700;
          fontSize = 50.sp;
        }
        break;
      case TextStyles.size44_900:
        {
          fontWeight = FontWeight.w900;
          fontSize = 44.sp;
        }
        break;
      case TextStyles.size40_900:
        {
          fontWeight = FontWeight.w900;
          fontSize = 40.sp;
        }
        break;
      case TextStyles.size36_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 36.sp;
        }
        break;
      case TextStyles.size32_800:
        {
          fontWeight = FontWeight.w800;
          fontSize = 32.sp;
        }
        break;
      case TextStyles.size32_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 32.sp;
        }
        break;
      case TextStyles.size32_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 32.sp;
        }
        break;
      case TextStyles.size32_400:
        {
          fontWeight = FontWeight.w400;
          fontSize = 32.sp;
        }
        break;
      case TextStyles.size28_800:
        {
          fontWeight = FontWeight.w800;
          fontSize = 28.sp;
        }
        break;

      case TextStyles.size28_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 28.sp;
        }
        break;
      case TextStyles.size24_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 24.sp;
        }
        break;
      case TextStyles.size24_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 24.sp;
        }
        break;
      case TextStyles.size24_400:
        {
          fontWeight = FontWeight.w700;
          fontSize = 24.sp;
        }
        break;
      case TextStyles.size22_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 22.sp;
        }
        break;
      case TextStyles.size20_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 20.sp;
        }
        break;
      case TextStyles.size20_400:
        {
          fontWeight = FontWeight.w400;
          fontSize = 20.sp;
        }
        break;
      case TextStyles.size18_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 18.sp;
        }
        break;
      case TextStyles.size18_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 18.sp;
        }
        break;
      case TextStyles.size18_500:
        {
          fontWeight = FontWeight.w500;
          fontSize = 18.sp;
        }
        break;

      case TextStyles.size18_400:
        {
          fontWeight = FontWeight.w400;
          fontSize = 18.sp;
        }
        break;
      case TextStyles.size17_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 18.sp;
        }
        break;
      case TextStyles.size16_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 16.sp;
        }
        break;
      case TextStyles.size16_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 16.sp;
        }
        break;
      case TextStyles.size16_500:
        {
          fontWeight = FontWeight.w500;
          fontSize = 16.sp;
        }
        break;
      case TextStyles.size16_400:
        {
          fontWeight = FontWeight.w400;
          fontSize = 16.sp;
        }
        break;
      case TextStyles.size15_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 15.sp;
        }
        break;
      case TextStyles.size15_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 15.sp;
        }
        break;
      case TextStyles.size15_400:
        {
          fontWeight = FontWeight.w400;
          fontSize = 15.sp;
        }
        break;
      case TextStyles.size15_300:
        {
          fontWeight = FontWeight.w300;
          fontSize = 15.sp;
        }
        break;

      case TextStyles.size14_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 14.sp;
        }
        break;
      case TextStyles.size14_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 14.sp;
        }
        break;
      case TextStyles.size14_500:
        {
          fontWeight = FontWeight.w500;
          fontSize = 14.sp;
        }
        break;

      case TextStyles.size14_400:
        {
          fontWeight = FontWeight.w400;
          fontSize = 14.sp;
        }
        break;
      case TextStyles.size14_300:
        {
          fontWeight = FontWeight.w300;
          fontSize = 14.sp;
        }
        break;
      case TextStyles.size12_700:
        {
          fontWeight = FontWeight.w700;
          fontSize = 12.sp;
        }
        break;
      case TextStyles.size12_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 12.sp;
        }
        break;
      case TextStyles.size12_500:
        {
          fontWeight = FontWeight.w500;
          fontSize = 12.sp;
        }
        break;
      case TextStyles.size12_400:
        {
          fontWeight = FontWeight.w400;
          fontSize = 12.sp;
        }
        break;
      case TextStyles.size10_400:
        {
          fontWeight = FontWeight.w400;
          fontSize = 10.sp;
        }
        break;
      case TextStyles.size10_500:
        {
          fontWeight = FontWeight.w500;
          fontSize = 10.sp;
        }
        break;
      case TextStyles.size10_600:
        {
          fontWeight = FontWeight.w600;
          fontSize = 10.sp;
        }
        break;
      case TextStyles.size8_400:
        {
          fontWeight = FontWeight.w400;
          fontSize = 8.sp;
        }
        break;
      default:
        {
          fontSize = 14.0.sp;
          fontWeight = FontWeight.w400;
        }
        break;
    }
  }

  getDefaultValues() {}

  @override
  Widget build(BuildContext context) {
    getStyle();
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: textOverflow,
        style: TextStyle(
          fontSize: (fontSize == 0.0) ? fontSizeDefault : fontSize,
          fontFamily: font,
          color: color,
          letterSpacing: letterSpacing,
          fontWeight: fontWeight,
          decoration: decoration,
          decorationThickness: 1.5,
        ));
  }
}
