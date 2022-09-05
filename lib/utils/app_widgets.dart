import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class AppWidgets {
  static void showSnackBar(BuildContext context, String message) {
    final _snackBar = SnackBar(
        content: Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: TextWidget(
        message,
        styles: TextStyles.size12_400,
        color: AppColors.white,
        maxLines: 5,
      ),
    ));
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  static Widget ourCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.lightPink,
        strokeWidth: 2.w,
      ),
    );
  }

  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,

      // barrierColor: AppColors.primaryAppColor.withOpacity(.05),
      builder: (context) => Theme(
        data: Theme.of(context)
            .copyWith(dialogBackgroundColor: Colors.transparent),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16.w),
            child: CircularProgressIndicator(
              color: AppColors.lightPink,
              strokeWidth: 2.w,
            ),
          ),
        ),
      ),
    );
  }

  showSuccessfulDialog(
    String title,
  ) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(
          fontFamily: "Montserrat", fontSize: 28.sp, color: AppColors.red),
    );
  }
}
