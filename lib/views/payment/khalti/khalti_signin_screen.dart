import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/payment/khalti/payment_khalti_controller.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/views/payment/khalti/khalti_otp_screen.dart';
import 'package:esikshya/views/payment/khalti/widgets/khalti_button.dart';

class KhaltiSigninScreen extends StatelessWidget {
  const KhaltiSigninScreen(
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    KhaltiPayController _khaltiPayController =
        Get.put(KhaltiPayController(childIdList, amount, save));

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
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
                  height: Get.height * .05,
                ),
                Form(
                  key: _khaltiPayController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _khaltiPayController.phoneNumber,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          hintText: "Khalti Mobile Number",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.length != 10) {
                            return "Please provide a valid phone number";
                          }
                        },
                      ),
                      SizedBox(
                        height: Get.height * .020,
                      ),
                      TextFormField(
                        controller: _khaltiPayController.transactionPin,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          hintText: "Khalti PIN",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a valid PIN";
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: KhaltiButton(
                    title: "PAY RS XX",
                    onTap: () async {
                      // TODO remove this later
                      if (_khaltiPayController.formKey.currentState!
                          .validate()) {
                        await _khaltiPayController.khaltiOne(context);
                      }
                      // Get.to(() => const KhaltiOtpScreen());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
