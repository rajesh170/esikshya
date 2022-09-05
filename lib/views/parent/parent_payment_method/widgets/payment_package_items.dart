import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/controllers/payment/payment_method_controller.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class PaymentPackageItems extends StatelessWidget {
  const PaymentPackageItems({
    Key? key,
    required this.plan,
    required this.amount,
    required this.paymentController,
  }) : super(key: key);
  final String plan;
  final String amount;
  final ParentPaymentController paymentController;

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return Ink(
      child: InkWell(
        onTap: () {
          paymentController.amount.value = int.parse(amount);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
          child: Row(
            children: [
              // done by peter
              // CircleAvatar(
              //   radius: 12.r,
              //   backgroundColor: AppColors.darkGrey,
              //   child: CircleAvatar(
              //     radius: 5.r,
              //     backgroundColor: AppColors.white,
              //   ),
              // ),
              // SizedBox(
              //   width: 20.w,
              // ),
              // TextWidget(
              //   plan,
              //   styles: TextStyles.size15_300,
              //   color: isDarkModeOn ? AppColors.white : AppColors.black,
              // ),
              // const Spacer(),
              // TextWidget(
              //   "\$$price",
              //   styles: TextStyles.size15_300,
              //   color: isDarkModeOn ? AppColors.white : AppColors.black,
              // ),

              Expanded(
                flex: 2,
                child: TextWidget(
                  "Rs. $amount",
                  styles: TextStyles.size12_400,
                  color: isDarkModeOn ? AppColors.white : AppColors.black,
                ),
              ),
              Expanded(
                flex: 5,
                child: TextWidget(
                  plan,
                  styles: TextStyles.size12_400,
                  color: isDarkModeOn ? AppColors.white : AppColors.black,
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(
                  () => Radio<int>(
                      value: int.parse(amount),
                      groupValue: paymentController.amount.value,
                      activeColor: AppColors.aqua,
                      focusColor: AppColors.white,
                      fillColor: MaterialStateProperty.all(AppColors.aqua),
                      onChanged: (value) {
                        paymentController.amount.value = value!;
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
