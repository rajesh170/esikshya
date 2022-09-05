import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/common/video_screens/video_list_screen.dart';

class SubjectDetails extends StatelessWidget {
  const SubjectDetails({Key? key, this.subject}) : super(key: key);
  final String? subject;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: subject == 'Physics'
                  ? AppColors.redPinkGradient
                  : subject == 'Mathematics'
                      ? AppColors.blackGradient
                      : subject == 'Biology'
                          ? AppColors.radialGradientBlue
                          : subject == 'Chemistry'
                              ? AppColors.cyanGradient
                              : subject == 'Technology'
                                  ? AppColors.greenGradient
                                  : subject == 'coding'
                                      ? AppColors.lightOrangeGradient
                                      : AppColors.blueGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(
                  leadingIcon: Icons.arrow_back,
                  iconColor: Colors.white,
                  iconSize: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/dots.png',
                            // height: 500,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Image.asset(
                            'assets/images/dots.png',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/sardar.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 15),
                  child: TextWidget(
                    '$subject Final Exam',
                    styles: TextStyles.size22_700,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextWidget('40 questions · 120 minutes',
                      styles: TextStyles.size12_400, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextWidget(
                    'You must complete this final exam to complete learning this semester. You must answer all the questions correctly, the time given is only 120 minutes. Your score in this test will be used to determine your success. You can retake once if your score are bad.',
                    styles: TextStyles.size14_500,
                    maxLines: 6,
                    color: Colors.white,
                    letterSpacing: 0.2,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),
                Stack(children: [
                  Column(
                    children: [
                      Positioned(
                        top: 100,
                        child: Row(children: [
                          Container(
                            width: 90,
                            margin: const EdgeInsets.only(top: 30, bottom: 0),
                            child: Image.asset('assets/images/dots.png'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 90,
                            margin: const EdgeInsets.only(top: 30, bottom: 0),
                            child: Image.asset('assets/images/dots.png'),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        SizedBox(
                          width: 90,
                          child: Image.asset('assets/images/dots.png'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 90,
                          child: Image.asset('assets/images/dots.png'),
                        ),
                      ]),
                    ],
                  ),
                  Positioned(
                    top: 100,
                    left: 25,
                    child: ButtonWidget(
                        onPressed: () {
                          Get.to(() => VideoListScreen(subject: subject!));
                        },
                        buttonText: 'START LEARNING ',
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red),
                  )
                ]),
              ],
            )));
  }
}
