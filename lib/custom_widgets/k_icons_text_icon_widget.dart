import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class IconTextArrowWidget extends StatelessWidget {
  const IconTextArrowWidget({
    Key? key,
    this.icon,
    required this.title,
    this.iconColor,
    this.onTap,
  }) : super(key: key);
  final IconData? icon;
  final String title;
  final Color? iconColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? AppColors.blue,
              size: 20.sp,
            ),
            SizedBox(
              width: 15.w,
            ),
            TextWidget(
              title,
              styles: TextStyles.size14_400,
              color: isDarkModeOn ? AppColors.white : AppColors.black,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 15.sp,
              color: AppColors.darkGrey,
            ),
          ],
        ),
      ),
    );
  }
}
