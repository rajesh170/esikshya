import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/parent/parent_set_password_controller.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/custom_widgets/k_form_field.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ParentAskNameScreen extends StatelessWidget {
  const ParentAskNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    ParentSetPasswordController _parentSetPasswordController =
        Get.put(ParentSetPasswordController());
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackground,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ButtonWidget(
        width: Get.width * 0.9,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await _parentSetPasswordController.saveParentName(
                context, _parentSetPasswordController.fullName.text);
          }
        },
        buttonText: "Next",
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                TextWidget(
                  "Enter your name to proceed",
                  color: AppColors.greyText,
                  styles: TextStyles.size18_400,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomFormField(
                    // autoFocus: true,
                    controller: _parentSetPasswordController.fullName,
                    hintText: "full name",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "cannot be empty";
                      }
                    }),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
