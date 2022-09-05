import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class CustomDialogesikshya {
  static openEsikshyaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          title: Container(
            height: Get.height * 0.3,
            color: AppColors.white,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.close,
                    size: 20.sp,
                    color: AppColors.black,
                  ),
                ),
                Image.asset(
                  "assets/images/dialog.png",
                  height: Get.height * 0.15,
                  width: 150.w,
                ),
                SizedBox(
                  height: 10.h,
                ),
                FittedBox(
                  child: TextWidget(
                    "Successfully added time tables!",
                    styles: TextStyles.size16_400,
                  ),
                ),
                const Spacer(),
                Container(
                  height: Get.height * 0.07,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.greyText,
                        width: 1.w,
                      ),
                      bottom: BorderSide(
                        color: AppColors.transparent,
                        width: 0.w,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        splashColor: AppColors.transparent,
                        focusColor: AppColors.transparent,
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: Get.height * 0.07,
                          width: Get.width * 0.39,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: AppColors.greyText,
                                width: 1.w,
                              ),
                            ),
                          ),
                          child: Center(
                            child: FittedBox(
                              child: TextWidget(
                                "Add another",
                                styles: TextStyles.size18_700,
                                color: AppColors.darkBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: AppColors.transparent,
                        focusColor: AppColors.transparent,
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: Get.height * 0.07,
                          width: Get.width * 0.39,
                          color: AppColors.darkBlue,
                          child: Center(
                            child: FittedBox(
                              child: TextWidget(
                                "Done",
                                styles: TextStyles.size18_700,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
