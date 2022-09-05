import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/utils/app_colors.dart';

class KhaltiButton extends StatelessWidget {
  const KhaltiButton({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: Get.width * .55,
        height: Get.height * .055,
        decoration: const BoxDecoration(
          color: AppColors.khaltiPurpleColor,
        ),
        child: const Center(
          child: Text(
            "VERIFY OTP",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
