import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/controllers/payment/payment_method_controller.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class PaymentMethodCardItems extends StatelessWidget {
  const PaymentMethodCardItems({
    Key? key,
    required this.image,
    required this.title,
    required this.paymentController,
  }) : super(key: key);
  final String image;
  final String title;
  final ParentPaymentController paymentController;

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return Ink(
      color: isDarkModeOn ? AppColors.darkThemeCardColor : AppColors.white,
      child: InkWell(
        onTap: () {
          paymentController.paymentMethod.value = title;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  image,
                  fit: BoxFit.fitHeight,
                  height: 15.h,
                  width: 15.h,
                ),
              ),
              Expanded(
                flex: 5,
                child: TextWidget(
                  title,
                  styles: TextStyles.size12_400,
                  color: isDarkModeOn ? AppColors.white : AppColors.black,
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(
                  () => Radio<String>(
                      value: title,
                      groupValue: paymentController.paymentMethod.value,
                      activeColor: AppColors.aqua,
                      focusColor: AppColors.white,
                      fillColor: MaterialStateProperty.all(AppColors.aqua),
                      onChanged: (String? value) {
                        paymentController.paymentMethod.value = value!;
                        print(paymentController.paymentMethod.value);
                        // print("tapped");
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
