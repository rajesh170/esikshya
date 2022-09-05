import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ChildProgressScreen extends StatelessWidget {
  const ChildProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkModeOn
            ? AppColors.darkThemeBackground
            : AppColors.scaffoldColor,
        appBar: CustomAppBar(
          title: "Progress",
          leadingIcon: Icons.arrow_back,
          appBarBackgroundColor: isDarkModeOn
              ? AppColors.darkThemeBackground
              : AppColors.scaffoldColor,
          centerTitle: false,
          txtColor: isDarkModeOn ? AppColors.white : AppColors.black,
          iconColor: isDarkModeOn ? AppColors.white : AppColors.black,
        ),
        body: Column(
          children: [
            ProgressItems(isDarkModeOn: isDarkModeOn),
            ProgressItems(isDarkModeOn: isDarkModeOn),
            ProgressItems(isDarkModeOn: isDarkModeOn),
          ],
        ),
      ),
    );
  }
}

class ProgressItems extends StatelessWidget {
  const ProgressItems({
    Key? key,
    required this.isDarkModeOn,
  }) : super(key: key);

  final bool isDarkModeOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.095,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: AppColors.transparent,
        border: Border(
          bottom: BorderSide(
            color: AppColors.greyText,
            width: 0.5.w,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color(0xffF6EFFF),
            child: Center(
              child: Icon(
                Icons.notifications,
                size: 20.sp,
                color: AppColors.red,
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  "Mathematics",
                  styles: TextStyles.size14_600,
                  color: isDarkModeOn ? AppColors.white : AppColors.black,
                ),
                SizedBox(
                  height: Get.height * 0.06,
                  child: TextWidget(
                    "Thomas just took maths class Thomas. Thomas just took maths class Thomas. Thomas just took maths class Thomas. Thomas just took maths class Thomas. Thomas just took maths class Thomas. Thomas just took maths class Thomas. Thomas just took maths class Thomas. Thomas just took maths class Thomas. Thomas just took maths class Thomas. Thomas just took maths class Thomas. ",
                    styles: TextStyles.size12_400,
                    color:
                        isDarkModeOn ? AppColors.greyText : AppColors.blackGrey,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: CircleAvatar(
              radius: 3.r,
              backgroundColor: AppColors.red,
            ),
          )
        ],
      ),
    );
  }
}
