import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/controllers/parent/parent_settings_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/on_boarding/esikshya.dart';
import 'package:esikshya/views/parent/parent_settings/parent_change_password.dart';
import 'package:esikshya/views/parent/parent_feedback/parent_feedback.dart';
import 'package:esikshya/views/parent/parent_settings/parent_support_screen.dart';

class ParentSettings extends StatelessWidget {
  const ParentSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DarkModecontroller _darkModeController = Get.put(DarkModecontroller());
    UserSettingsController _parentSettingController =
        Get.put(UserSettingsController());
    var _sharedPref = Get.find<AppSharedPreferences>();
    return SafeArea(
      child: Obx(
        () => Scaffold(
          backgroundColor: _darkModeController.isDarkModeOn.value
              ? AppColors.darkThemeBackground
              : AppColors.scaffoldColor,
          appBar: CustomAppBar(
            title: "Settings",
            leadingIcon: Icons.arrow_back,
            txtColor: _darkModeController.isDarkModeOn.value
                ? AppColors.white
                : AppColors.black,
            appBarBackgroundColor: _darkModeController.isDarkModeOn.value
                ? AppColors.darkThemeBackground
                : AppColors.scaffoldColor,
            iconColor: _darkModeController.isDarkModeOn.value
                ? AppColors.white
                : AppColors.blue,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: _darkModeController.isDarkModeOn.value
                      ? AppColors.darkThemeCardColor
                      : AppColors.white,
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
                      IconTextArrowWidget(
                        title: "Change Password",
                        icon: Icons.settings,
                        onTap: () {
                          Get.to(() => const ParentChangePassword());
                        },
                      ),
                      IconTextArrowWidget(
                        title: "Support",
                        icon: Icons.headset_mic_outlined,
                        onTap: () {
                          Get.to(() => const ParentSupportScreen());
                        },
                      ),
                      IconTextArrowWidget(
                        title: "Privacy & Data",
                        icon: Icons.lock_outline,
                        onTap: () {},
                      ),
                      IconTextArrowWidget(
                        title: "Feedback",
                        icon: Icons.settings,
                        onTap: () {
                          Get.to(() => const ParentFeedback());
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                  color: _darkModeController.isDarkModeOn.value
                      ? AppColors.darkThemeCardColor
                      : AppColors.white,
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.dark_mode_outlined,
                          color: _darkModeController.isDarkModeOn.value
                              ? AppColors.white
                              : AppColors.blue,
                          size: 20.sp,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        TextWidget(
                          "Dark Mode",
                          styles: TextStyles.size14_400,
                          color: _darkModeController.isDarkModeOn.value
                              ? AppColors.white
                              : AppColors.black,
                        ),
                        const Spacer(),
                        Obx(
                          () => Switch(
                            inactiveThumbColor: AppColors.blue,
                            inactiveTrackColor: AppColors.blueishGrey,
                            activeColor: AppColors.blue,
                            activeTrackColor:
                                _darkModeController.isDarkModeOn.value
                                    ? AppColors.blueishGrey
                                    : AppColors.darkGrey,
                            value: _darkModeController.isDarkModeOn.value,
                            onChanged: (value) {
                              _darkModeController.isDarkModeOn.value =
                                  !_darkModeController.isDarkModeOn.value;
                              // ignore: avoid_print
                              print(_darkModeController.isDarkModeOn.value);
                              Get.find<AppSharedPreferences>().saveIsDarkModeOn(
                                  _darkModeController.isDarkModeOn.value);
                              // ignore: avoid_print
                              print(_darkModeController.isDarkModeOn.value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                  color: _darkModeController.isDarkModeOn.value
                      ? AppColors.darkThemeCardColor
                      : AppColors.white,
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: IconTextArrowWidget(
                    title: "Sign Out",
                    icon: Icons.power_settings_new,
                    iconColor: AppColors.red,
                    onTap: () {
                      // OnTapPopDialog.openesikshyaDialog();
                      Get.dialog(
                        AlertDialog(
                          titlePadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          title: SizedBox(
                            height: Get.height * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.08,
                                ),
                                Expanded(
                                  child: TextWidget(
                                    "Are you sure you want\n to sign out?",
                                    styles: TextStyles.size20_600,
                                    color: AppColors.white,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
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
                                            child: TextWidget(
                                              "No",
                                              styles: TextStyles.size18_700,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: AppColors.transparent,
                                        focusColor: AppColors.transparent,
                                        onTap: () async {
                                          var tempToken = await _sharedPref
                                              .getChildAccessToken();

                                          if (tempToken!.isEmpty) {
                                            await _parentSettingController
                                                .removeParentFcmTokenFromServer(
                                                    context);
                                          } else {
                                            await _parentSettingController
                                                .removeChildFcmTokenFromServer(
                                                    context);
                                          }

                                          await _sharedPref
                                              .removeParentDetails();
                                          await _sharedPref
                                              .removeChildDetails();
                                          Get.offAll(
                                            () => const EsikshyaBoarding(),
                                          );
                                        },
                                        child: SizedBox(
                                          height: Get.height * 0.07,
                                          width: Get.width * 0.39,
                                          child: Center(
                                            child: TextWidget(
                                              "Yes",
                                              styles: TextStyles.size18_700,
                                              color: AppColors.lightPink,
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
                          backgroundColor: const Color(0xff484692),
                        ),
                        barrierColor:
                            AppColors.darkThemeBackground.withOpacity(0.85),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
            Expanded(
              flex: 3,
              child: TextWidget(
                title,
                styles: TextStyles.size14_400,
                color: isDarkModeOn ? AppColors.white : AppColors.black,
              ),
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
