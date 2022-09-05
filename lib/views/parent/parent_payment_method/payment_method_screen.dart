import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/controllers/payment/esewa/payment_esewa_controller.dart';
import 'package:esikshya/controllers/payment/payment_method_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/db/database_helper.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/parent/parent_payment_method/widgets/child_selector_widget.dart';
import 'package:esikshya/views/parent/parent_payment_method/widgets/payment_method_general_widget.dart';
import 'package:esikshya/views/parent/parent_payment_method/widgets/payment_method_items.dart';
import 'package:esikshya/views/parent/parent_payment_method/widgets/payment_package_items.dart';
import 'package:esikshya/views/payment/khalti/khalti_signin_screen.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    ParentPaymentController _paymentController =
        Get.put(ParentPaymentController());
    DatabaseHelper _db = DatabaseHelper.instance;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkModeOn
            ? AppColors.darkThemeBackground
            : AppColors.scaffoldColor,
        appBar: CustomAppBar(
          title: "Payment",
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 5.h),
          // main body
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // upper portion
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // child list
                      GeneralWidget(
                        widgetTitle: "Select Child",
                        isDarkModeOn: isDarkModeOn,
                        // db: _db,
                        childWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChildSelectorWidget(
                              isDarkModeOn: isDarkModeOn,
                              db: _db,
                              paymentController: _paymentController,
                            ),
                            // child list empty error
                            Obx(
                              () => Text(
                                _paymentController.childListError.value,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // choose payment method
                      GeneralWidget(
                        widgetTitle: "Choose Payment Method",
                        isDarkModeOn: isDarkModeOn,
                        childWidget: Ink(
                          color: isDarkModeOn
                              ? AppColors.darkThemeCardColor
                              : AppColors.white,
                          child: Column(
                            children: [
                              PaymentMethodCardItems(
                                image: "assets/images/math_icon.png",
                                title: "Esewa",
                                paymentController: _paymentController,
                              ),
                              PaymentMethodCardItems(
                                image: "assets/images/math_icon.png",
                                title: "Khalti",
                                paymentController: _paymentController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // choose package
                      GeneralWidget(
                        widgetTitle: "Select Subscription",
                        isDarkModeOn: isDarkModeOn,
                        childWidget: Ink(
                          color: isDarkModeOn
                              ? AppColors.darkThemeCardColor
                              : AppColors.white,
                          child: Column(
                            children: [
                              PaymentPackageItems(
                                plan: "1 month",
                                amount: "500",
                                paymentController: _paymentController,
                              ),
                              PaymentPackageItems(
                                plan: "6 months",
                                amount: "2800",
                                paymentController: _paymentController,
                              ),
                              PaymentPackageItems(
                                plan: "Yearly",
                                amount: "5500",
                                paymentController: _paymentController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // save the payment
              Container(
                color: isDarkModeOn
                    ? AppColors.darkThemeCardColor
                    : AppColors.white,
                child: Row(
                  children: [
                    TextWidget(
                      "Save payment details",
                      styles: TextStyles.size12_400,
                      color: isDarkModeOn ? AppColors.white : AppColors.black,
                    ),
                    const Spacer(),
                    Switch(
                      value: _paymentController.save.value,
                      onChanged: (newValue) {
                        _paymentController.save.value = newValue;
                      },
                    ),
                  ],
                ),
              ),
              // pay now button
              ButtonWidget(
                width: Get.width,
                onPressed: () async {
                  if (_paymentController.childIdList.isEmpty) {
                    _paymentController.childListError.value =
                        "Please select at least one child";
                  } else if (_paymentController.childIdList.isNotEmpty) {
                    _paymentController.childListError.value = "";
                    switch (_paymentController.paymentMethod.value) {
                      case "Khalti":
                        Get.to(() => KhaltiSigninScreen(
                              amount: _paymentController.amount.value *
                                  _paymentController.childIdList.length *
                                  100,
                              childIdList: _paymentController.childIdList.value,
                              save: _paymentController.save.value,
                            ));
                        break;

                      case "Esewa":
                        AppWidgets.showSnackBar(context, "Go to Esewa");
                        AppSharedPreferences _sharedPref =
                            AppSharedPreferences();
                        Future parentPhoneNumber =
                            await _sharedPref.getParentPhoneNumber();

                        EsewaPayController esewaPaymentController =
                            EsewaPayController(
                          childIdList: _paymentController.childIdList.value,
                          productPrice: _paymentController.amount.value *
                              _paymentController.childIdList.length,
                          save: _paymentController.save.value,
                          parentPhoneNumber: parentPhoneNumber.toString(),
                        );

                        esewaPaymentController.makePayment(context);
                        break;
                    }
                  }
                },
                color: isDarkModeOn ? AppColors.darkBlue : AppColors.lightPink,
                buttonText: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
