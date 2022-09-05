import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/student/student_sign_up_controller.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class StudentSignUpScreen extends StatelessWidget {
  const StudentSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentSignUpController _studentSignupController =
        Get.put(StudentSignUpController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkThemeBackground,
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  TextWidget(
                    "Enter your \nParent's Code Number",
                    styles: TextStyles.size32_600,
                    color: AppColors.white,
                    maxLines: 5,
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Get.height * 0.11,
                  ),
                  // Row(
                  //   children: [
                  // TextWidget(
                  //   "+977",
                  //   styles: TextStyles.size18_400,
                  // ),
                  TextFormField(
                    cursorColor: AppColors.black,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.length < 10 || value.length > 10) {
                        return "Invalid code";
                      }
                    },
                    decoration: InputDecoration(
                      // Hardcoded country code only for nepal
                      // prefix: TextWidget(
                      //   "+977",
                      //   styles: TextStyles.size18_400,
                      // ),
                      hintText: "xcnhd.....",

                      // Country Code picker for future international otp implementation
                      // prefixIcon: CountryCodePicker(
                      //   flagWidth: 20.w,
                      //   textStyle: TextStyle(
                      //     fontFamily: "Montserrat",
                      //     fontSize: 17.sp,
                      //     fontWeight: FontWeight.w400,
                      //     color: AppColors.black,
                      //   ),
                      //   onChanged: print,
                      //   initialSelection: 'NP',
                      //   favorite: const ['+977', 'NP', "IN"],
                      //   // optional. Shows only country name and flag
                      //   showCountryOnly: false,
                      //   // optional. Shows only country name and flag when popup is closed.
                      //   showOnlyCountryWhenClosed: false,
                      //   // optional. aligns the flag and the Text left
                      //   alignLeft: false,
                      // ),

                      suffixIcon: InkWell(
                        onTap: () {
                          _studentSignupController.parentKeyController.clear();
                        },
                        child: Icon(
                          Icons.close,
                          size: 15.sp,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      fillColor: AppColors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(15.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: const Color(0xffE9E9F1),
                          width: 1.5.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: const Color(0xffE9E9F1),
                          width: 1.5.w,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 1.5.w,
                        ),
                      ),

                      hintStyle: TextStyle(
                        color: const Color(0xffA3A3AE),
                        fontFamily: "Montserrat",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    controller: _studentSignupController.parentKeyController,
                    style: TextStyle(
                      color: AppColors.black,
                      fontFamily: "Montserrat",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  ButtonWidget(
                    width: Get.width,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _studentSignupController
                            .studentCheckParent(context);
                      }
                    },
                    buttonText: "Verify Parent",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
