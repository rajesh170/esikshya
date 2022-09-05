import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/splash_controller.dart';
import 'package:esikshya/utils/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _splashController = Get.find<SplashController>();
    return Scaffold(
        backgroundColor: AppColors.darkThemeBackground,
        body: FutureBuilder(
          future: _splashController.userWelcomed(),
          builder: (context, snapshot) {
            return Center(
              child: Image.asset(
                "assets/images/login_screen.png",
                width: Get.width * 0.9,
                height: Get.height * 0.7,
                fit: BoxFit.fill,
              ),
            );
          },
        ));
  }
}
