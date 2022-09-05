import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/student_subscription_info_screen/student_subscription_info_screen.dart';

class StudentSubjectDetails extends StatelessWidget {
  const StudentSubjectDetails({
    Key? key,
    required this.subjectName,
    required this.imagePath,
    required this.scientistContribution,
    required this.scientistName,
  }) : super(key: key);
  final String subjectName;
  final String imagePath;
  final String scientistContribution;
  final String scientistName;

  @override
  Widget build(BuildContext context) {
    MyScrollController _msc = Get.put(MyScrollController());
    return Scaffold(
        backgroundColor: AppColors.black,
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: DefaultTabController(
            length: 2,
            child: NotificationListener(
              onNotification: (notification) {
                log("HI" + _msc.controller.position.pixels.toString());
                if (_msc.controller.position.pixels > 10) {
                  _msc.showCrossIcon.value = false;
                }
                if (_msc.controller.position.pixels == 0) {
                  _msc.showCrossIcon.value = true;
                }
                // if (_msc.controller.position.pixels < 130) {
                //   _msc.showCrossIcon.value = false;
                // }
                // if (_msc.controller.position.pixels < 40) {
                //   _msc.showCrossIcon.value = false;
                // }
                return true;
              },
              child: NestedScrollView(
                  controller: _msc.controller,
                  headerSliverBuilder: (context, value) {
                    log(Get.height.toString());
                    return [
                      // SliverToBoxAdapter(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 30),
                      //     child: Icon(
                      //       Icons.place,
                      //       color: AppColors.white,
                      //       size: 30.sp,
                      //     ),
                      //   ),
                      // ),
                      SliverAppBar(
                          elevation: 1.h,
                          expandedHeight: Get.height * 0.96,
                          // collapsedHeight: Get.height * 0.05,
                          toolbarHeight: 0.h,
                          automaticallyImplyLeading: true,
                          backgroundColor: AppColors.transparent,
                          pinned: true,
                          floating: true,
                          bottom: TabBar(
                            indicatorPadding: EdgeInsets.symmetric(
                              horizontal: 15.h,
                            ),
                            indicatorColor: AppColors.white,
                            unselectedLabelColor:
                                AppColors.white.withOpacity(0.8),
                            unselectedLabelStyle: TextStyle(
                              color: AppColors.greyText,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Montserrat",
                            ),
                            labelColor: AppColors.white,
                            labelStyle: TextStyle(
                              color: AppColors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Montserrat",
                            ),
                            tabs: [
                              Container(
                                height: Get.height * 0.05,
                                width: Get.width,
                                color: AppColors.transparent,
                                child: const Center(
                                  child: FittedBox(
                                    child: Text("BIOGRAPHY"),
                                  ),
                                ),
                              ),
                              Container(
                                height: Get.height * 0.05,
                                width: Get.width,
                                color: AppColors.transparent,
                                child: const Center(
                                  child: FittedBox(
                                    child: Text("LESSONS"),
                                  ),
                                ),
                              ),
                              // Text("Watching"),
                            ],
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(
                                  () => _msc.showCrossIcon.value
                                      ? InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Icon(
                                              Icons.close,
                                              color: AppColors.white,
                                              size: 30.sp,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                SizedBox(
                                  height: Get.height * 0.5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [
                                      const Color(0xff262626).withOpacity(0.05),
                                      const Color(0xff707070).withOpacity(0.01)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        TextWidget(
                                          scientistContribution,
                                          styles: TextStyles.size14_500,
                                          color: AppColors.white,
                                        ),
                                        TextWidget(
                                          scientistName,
                                          styles: TextStyles.size22_700,
                                          color: AppColors.white,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.1,
                                        ),
                                        ButtonWidget(
                                          width: Get.width * 0.9,
                                          onPressed: () {
                                            Get.to(() =>
                                                const StudentSubscriptionInfoScreen());
                                          },
                                          buttonText: "START LEARNING",
                                        ),
                                        SizedBox(height: Get.height * 0.02),
                                        TextWidget(
                                          "WATCH FREE LESSONS",
                                          styles: TextStyles.size12_700,
                                          color: AppColors.white,
                                        ),
                                        SizedBox(height: Get.height * 0.15),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ];
                  },
                  body: TabBarView(children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      color: AppColors.black,
                    ),
                    Container(
                      height: Get.height,
                      width: Get.width,
                      color: AppColors.black,
                    ),
                  ])),
            ),
          ),
        ));
  }
}

class MyScrollController extends GetxController {
  late ScrollController controller;
  @override
  void onInit() {
    controller = ScrollController();
    super.onInit();
  }

  var showCrossIcon = true.obs;
}
