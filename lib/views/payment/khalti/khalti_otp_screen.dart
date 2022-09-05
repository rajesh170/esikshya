import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/payment/khalti/payment_khalti_controller.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/views/payment/khalti/widgets/khalti_button.dart';

class KhaltiOtpScreen extends StatelessWidget {
  const KhaltiOtpScreen(
      {Key? key,
      required this.childIdList,
      required this.amount,
      required this.save})
      : super(key: key);

  final List<int> childIdList;
  final int amount;
  final bool save;

  @override
  Widget build(BuildContext context) {
    KhaltiPayController _khaltiPayController =
        Get.put(KhaltiPayController(childIdList, amount, save));
    double height = Get.height;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        body: Container(
          height: Get.height,
          // height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    IconData(0xee33, fontFamily: 'MaterialIcons'),
                    color: AppColors.khaltiPurpleColor,
                  ),
                  SizedBox(width: 5),
                  Text("KHALTI"),
                ],
              ),
              SizedBox(
                height: Get.height * .05,
              ),
              SvgPicture.asset("assets/icons/khalti_logo.svg",
                  height: Get.height * .085),
              SizedBox(
                height: Get.height * .025,
              ),
              Text(
                "Please verify OTP",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15.sp,
                ),
                // textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * .025,
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
                        return KhaltiOtpFormField(
                          controller: index == 0
                              ? _khaltiPayController.otp1
                              : index == 1
                                  ? _khaltiPayController.otp2
                                  : index == 2
                                      ? _khaltiPayController.otp3
                                      : index == 3
                                          ? _khaltiPayController.otp4
                                          : index == 4
                                              ? _khaltiPayController.otp5
                                              : _khaltiPayController.otp6,
                        );
                      }),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              KhaltiButton(
                title: "PAY RS XX",
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  _khaltiPayController.otp1.text == "" ||
                          _khaltiPayController.otp2.text == "" ||
                          _khaltiPayController.otp3.text == "" ||
                          _khaltiPayController.otp4.text == "" ||
                          _khaltiPayController.otp5.text == "" ||
                          _khaltiPayController.otp6.text == ""
                      ? AppWidgets.showSnackBar(context,
                          "Please fill the otp sent to your provided number.")
                      : () async {
                          // await _khaltiPayController.khaltiTwo(context);
                          // await _khaltiPayController.khaltiThree(context);
                        };
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class KhaltiOtpFormField extends StatelessWidget {
  const KhaltiOtpFormField({
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
        border: Border.all(
          width: 2.5,
          color: Colors.grey,
          // color: AppColors.khaltiPurpleColor,
          // color: Colors.blueGrey,
        ),
        // borderRadius: BorderRadius.circular(8.r),
        borderRadius: BorderRadius.zero,
        // color: AppColors.black,
      ),
      child: Center(
        child: TextFormField(
          cursorColor: AppColors.khaltiPurpleColor,
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
            // fontFamily: "Montserrat",
            fontSize: 30.sp,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
