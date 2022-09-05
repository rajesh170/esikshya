import 'package:flutter/material.dart';
import 'package:esikshya/views/on_boarding/on_boarding1.dart';
import 'package:esikshya/views/on_boarding/on_boarding2.dart';
import 'package:esikshya/views/on_boarding/on_boarding3.dart';

class WelComeScreen extends StatelessWidget {
  const WelComeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          OnBoarding1(
            onButtonPressed: () {
              pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            },
          ),
          OnBoarding2(
            onButtonPressed: () {
              pageController.animateToPage(
                2,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            },
          ),
          const OnBoarding3(),
        ],
      ),
    );
  }
}
