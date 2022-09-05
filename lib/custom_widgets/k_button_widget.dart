import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final bool? needBorder;

  const ButtonWidget({
    Key? key,
    this.width,
    this.height,
    required this.onPressed,
    required this.buttonText,
    this.gradient,
    this.color,
    this.borderRadius,
    this.needBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 44.h,
        width: width ?? 311.w,
        decoration: BoxDecoration(
          gradient: gradient,
          color: needBorder == null || needBorder == false
              ? color ?? AppColors.darkBlue
              : null,
          borderRadius: borderRadius ?? BorderRadius.circular(5.r),
          border: needBorder == null || needBorder == false
              ? null
              : Border.all(
                  color: color ?? AppColors.darkBlue,
                  width: 1.w,
                ),
        ),
        child: Center(
          child: TextWidget(
            buttonText,
            color: AppColors.white,
            styles: TextStyles.size16_600,
          ),
        ),
      ),
    );
  }
}
