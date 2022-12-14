import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/parent/parent_sign_up_controller.dart';
import 'package:esikshya/controllers/student/timer_controller.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/utils/text_widget.dart';

class ParentOTPScreen extends StatelessWidget {
  const ParentOTPScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ParentSignUpController _parentAuthController =
        Get.put(ParentSignUpController());
    CountController _countController = Get.put(CountController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkThemeBackground,
        body: SingleChildScrollView(
          child: Container(
            // height: Get.height * 0.8,
            // color: AppColors.aqua,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/images/otp_icon.png",
                      height: Get.height * 0.15,
                      width: Get.width * 0.3,
                      fit: BoxFit.fitHeight,
                    ),
                    Expanded(
                      child: TextWidget(
                        "Enter code",
                        styles: TextStyles.size32_600,
                        color: AppColors.white,
                        maxLines: 5,
                        // textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.09,
                ),
                TextWidget(
                  "OTP has been sent to your mobile number.",
                  styles: TextStyles.size14_300,
                  color: AppColors.greyText,
                  maxLines: 5,
                  // textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextWidget(
                  "Please verify",
                  styles: TextStyles.size14_300,
                  color: AppColors.greyText,
                  maxLines: 5,
                  // textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  height: Get.height * 0.06,
                  width: Get.width,
                  child: Center(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return OTPFormField(
                            controller: index == 0
                                ? _parentAuthController.otp1
                                : index == 1
                                    ? _parentAuthController.otp2
                                    : index == 2
                                        ? _parentAuthController.otp3
                                        : index == 3
                                            ? _parentAuthController.otp4
                                            : index == 4
                                                ? _parentAuthController.otp5
                                                : _parentAuthController.otp6,
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        "Didn???t get the code?",
                        styles: TextStyles.size14_300,
                        color: AppColors.greyText,
                        maxLines: 5,
                        // textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                        child: GetBuilder<CountController>(
                      initState: (data) => _countController.startCounter(),
                      builder: (controller) {
                        print(controller.count);
                        return TextWidget(
                          "Resend OTP (00:${controller.count})",
                          styles: TextStyles.size14_300,
                          color: AppColors.lightGreen,
                          maxLines: 5,
                          // textAlign: TextAlign.center,
                        );
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                ButtonWidget(
                  width: Get.width,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    _parentAuthController.otp1.text == "" ||
                            _parentAuthController.otp2.text == "" ||
                            _parentAuthController.otp3.text == "" ||
                            _parentAuthController.otp4.text == "" ||
                            _parentAuthController.otp5.text == "" ||
                            _parentAuthController.otp6.text == ""
                        ? AppWidgets.showSnackBar(context,
                            "Please fill the otp sent to your provided number.")
                        : await _parentAuthController.parentOTPAuth(context);
                  },
                  buttonText: "Verify OTP",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPFormField extends StatelessWidget {
  const OTPFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.04,
      width: Get.height * 0.05,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.white,
      ),
      child: Center(
        child: TextFormField(
          cursorColor: AppColors.black,
          // cursorHeight: 20.h,
          keyboardType: TextInputType.number,
          maxLength: 1,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          decoration: InputDecoration(
            // fillColor: AppColors.white,
            counterText: "",
            filled: true,
            contentPadding: EdgeInsets.only(left: 10.w),
            border: InputBorder.none,
          ),
          controller: controller,
          style: TextStyle(
            color: AppColors.black,
            fontFamily: "Montserrat",
            fontSize: 30.sp,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
