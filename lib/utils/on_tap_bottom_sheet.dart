import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/text_widget.dart';

import 'app_colors.dart';

class OnTapBottomSheet {
  static openBottomSheet(
      List items, Rx storeTo, String storedAt, String bottomSheetHeading,
      {bool? isDarkModeOn}) {
    Get.bottomSheet(
      SizedBox(
        height: Get.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.scaffoldColor,
                      width: 2.h,
                    ),
                  ),
                ),
                child: TextWidget(
                  bottomSheetHeading,
                  styles: TextStyles.size14_400,
                  color:
                      isDarkModeOn == true ? AppColors.white : AppColors.black,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        storeTo.value = items[index].toString();
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 7.h, horizontal: 15.w),
                        width: Get.width,
                        child: Row(
                          children: [
                            Container(
                              height: 8.h,
                              width: 8.h,
                              decoration: BoxDecoration(
                                border: storedAt == items[index].toString()
                                    ? null
                                    : Border.all(
                                        width: 0.5.sp, color: AppColors.black),
                                color: storedAt == items[index].toString()
                                    ? AppColors.aqua
                                    : isDarkModeOn == true
                                        ? AppColors.white
                                        : AppColors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 15.h,
                            ),
                            TextWidget(
                              items[index].toString(),
                              styles: TextStyles.size12_400,
                              color: isDarkModeOn == true
                                  ? AppColors.white
                                  : AppColors.darkGrey,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      backgroundColor: isDarkModeOn == true
          ? AppColors.darkThemeBackground
          : AppColors.white,
    );
  }
}
