import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ContainerWithIConTextAndArrow extends StatelessWidget {
  const ContainerWithIConTextAndArrow({
    Key? key,
    required this.text,
    required this.circleColor,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final String text;
  final Color circleColor;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 48.h,
        child: Center(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: circleColor,
                radius: 20,
                child: Container(
                  decoration: BoxDecoration(
                      // color: circleColor,
                      borderRadius: BorderRadius.circular(100.r)),
                  child: Icon(
                    icon,
                    color: AppColors.white,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 11.w,
              ),
              TextWidget(
                text,
                styles: TextStyles.size14_500,
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 12.sp,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
