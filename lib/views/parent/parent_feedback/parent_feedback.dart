import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/parent/parent_feedback/parent_feedback_sent_success.dart';

class ParentFeedback extends StatelessWidget {
  const ParentFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _description = TextEditingController();
    // TextEditingController _newPassword = TextEditingController();
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkModeOn
            ? AppColors.darkThemeBackground
            : AppColors.scaffoldColor,
        appBar: CustomAppBar(
          title: "Feedback",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                TextWidget(
                  "Please write your valuable feedback",
                  styles: TextStyles.size12_400,
                  maxLines: 2,
                  color:
                      isDarkModeOn ? AppColors.greyText : AppColors.blackGrey,
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextWidget(
                  "Description",
                  styles: TextStyles.size14_600,
                  color: isDarkModeOn ? AppColors.white : AppColors.black,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 200.h,
                  child: TextFormField(
                    maxLines: 500,
                    style: TextStyle(
                      color: isDarkModeOn
                          ? AppColors.greyText
                          : AppColors.blackGrey,
                      fontFamily: "Montserrat",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.h,
                        vertical: 10,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: isDarkModeOn
                              ? AppColors.darkBlue
                              : const Color(0xffE9E9F1),
                          width: 1.5.h,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: isDarkModeOn
                              ? AppColors.darkBlue
                              : const Color(0xffE9E9F1),
                          width: 1.5.h,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: isDarkModeOn
                              ? AppColors.darkBlue
                              : const Color(0xffE9E9F1),
                          width: 1.5.h,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 1.5.h,
                        ),
                      ),

                      // prefixIcon: Icon(
                      //   prefixIcon,
                      //   size: 20.sp,
                      //   color: const Color(0xff6F6F79),
                      // ),
                      hintText: "Text Area",
                      hintStyle: TextStyle(
                        color: const Color(0xffA3A3AE),
                        fontFamily: "Montserrat",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    controller: _description,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                ButtonWidget(
                  width: Get.width,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Get.to(() => const ParentFeedbackSentSuccess());
                  },
                  buttonText: "Submit",
                  color:
                      isDarkModeOn ? AppColors.darkBlue : AppColors.lightPink,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
