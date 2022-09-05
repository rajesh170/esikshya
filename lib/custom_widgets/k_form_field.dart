import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/utils/app_colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.autoFocus,
    this.onChanged,
    this.onEditingComplete,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? autoFocus;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return TextFormField(
      onChanged: onChanged,
      autofocus: autoFocus ?? false,
      validator: validator,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isDarkModeOn ? AppColors.darkBlue : const Color(0xffE9E9F1),
            width: 0.7.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isDarkModeOn ? AppColors.darkBlue : const Color(0xffE9E9F1),
            width: 0.7.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isDarkModeOn ? AppColors.darkBlue : const Color(0xffE9E9F1),
            width: 0.7.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 0.7.w,
          ),
        ),
        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                size: 20.sp,
                color: const Color(0xff6F6F79),
              ),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xffA3A3AE),
          fontFamily: "Montserrat",
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      controller: controller,
      obscureText: obscureText ?? false,
      style: TextStyle(
        color: isDarkModeOn ? AppColors.greyText : AppColors.darkGrey,
        fontFamily: "Montserrat",
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      textInputAction: textInputAction ?? TextInputAction.done,
      keyboardType: keyboardType ?? TextInputType.text,
      obscuringCharacter: "*",
    );
  }
}
