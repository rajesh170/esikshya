import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ParentSupportScreen extends StatelessWidget {
  const ParentSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkModeOn
            ? AppColors.darkThemeBackground
            : AppColors.scaffoldColor,
        appBar: CustomAppBar(
          title: "Support",
          leadingIcon: Icons.arrow_back,
          appBarBackgroundColor: isDarkModeOn
              ? AppColors.darkThemeBackground
              : AppColors.scaffoldColor,
          centerTitle: true,
          txtColor: isDarkModeOn ? AppColors.white : AppColors.black,
          // trailingIcon: Icons.settings,
          iconColor: isDarkModeOn ? AppColors.white : AppColors.blackGrey,
          iconSize: 20.sp,
        ),
        body: Column(
          children: [
            Divider(
              thickness: 0.5.h,
              color: isDarkModeOn ? AppColors.greyText : AppColors.darkGrey,
            ),
            const HelpContainer(
              icon: Icons.email_rounded,
              title: "Email",
              subtitle: "help@example.app",
            ),
            Divider(
              thickness: 0.5.h,
              color: isDarkModeOn ? AppColors.greyText : AppColors.darkGrey,
            ),
            const HelpContainer(
              icon: Icons.call_outlined,
              title: "Contact",
              subtitle: "98045625688",
            ),
            Divider(
              thickness: 0.5.h,
              color: isDarkModeOn ? AppColors.greyText : AppColors.darkGrey,
            ),
            const HelpContainer(
              icon: Icons.link_sharp,
              title: "Website",
              subtitle: "https://example.app",
            ),
            Divider(
              thickness: 0.5.h,
              color: isDarkModeOn ? AppColors.greyText : AppColors.darkGrey,
            ),
          ],
        ),
      ),
    );
  }
}

class HelpContainer extends StatelessWidget {
  const HelpContainer({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
      // color: AppColors.red,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: isDarkModeOn ? AppColors.darkBlue : AppColors.lightPink,
          ),
          SizedBox(
            width: 15.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title,
                styles: TextStyles.size14_500,
                color: isDarkModeOn ? AppColors.white : AppColors.black,
              ),
              TextWidget(
                subtitle,
                styles: TextStyles.size14_400,
                color: isDarkModeOn ? AppColors.darkBlue : AppColors.lightPink,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
