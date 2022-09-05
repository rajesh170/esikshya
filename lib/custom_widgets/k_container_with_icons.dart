import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class CustomContainerWithIcons extends StatelessWidget {
  const CustomContainerWithIcons({
    Key? key,
    required this.color,
    required this.containerName,
    required this.imgBackgroundColor,
    required this.imgPath,
    this.onTap,
  }) : super(key: key);
  final Color? color;
  final String? imgPath;
  final Color? imgBackgroundColor;
  final String? containerName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // // height: 100.h,
        // // width: 155.w,
        // constraints: BoxConstraints(
        //   maxHeight: 100.h,
        //   // minHeight: 100.h,
        //   maxWidth: 150.w,
        //   // minWidth: 155.w,
        // ),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: 44.h,
              // width: 44.h,
              margin: EdgeInsets.only(bottom: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: imgBackgroundColor,
              ),
              child: Image.asset(
                imgPath!,
                height: 44.h,
                width: 44.h,
              ),
            ),
            SizedBox(
              width: Get.width * 0.36,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: containerName!.length > 10
                        ? FittedBox(
                            child: TextWidget(
                              containerName!,
                              styles: TextStyles.size14_600,
                              color: AppColors.white,
                              maxLines: 2,
                            ),
                          )
                        : TextWidget(
                            containerName!,
                            styles: TextStyles.size14_600,
                            color: AppColors.white,
                            maxLines: 2,
                          ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 12.sp,
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
