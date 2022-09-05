import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/children_details_controller.dart';
import 'package:esikshya/controllers/parent/parent_edit_profile_controller.dart';
import 'package:esikshya/custom_widgets/k_container_with_icon_text_arrow.dart';
import 'package:esikshya/custom_widgets/k_container_with_icons.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/parent/parent_account.dart';
import 'package:esikshya/views/parent/parent_payment_method/payment_method_screen.dart';
import 'package:esikshya/views/parent/parent_settings/parent_settings.dart';
import 'package:esikshya/views/parent/parent_time_table.dart';

class ParentDashBoard extends StatelessWidget {
  const ParentDashBoard({
    Key? key,
    this.name,
  }) : super(key: key);
  final String? name;

  @override
  Widget build(BuildContext context) {
    ParentEditProfileController _editParentDetailController =
        Get.put(ParentEditProfileController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blue,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 271.h,
              backgroundColor: AppColors.blue,
              flexibleSpace: PreferredSize(
                preferredSize: const Size(double.infinity, kToolbarHeight),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 79.h),
                      Center(
                          child: CircleAvatar(
                        backgroundColor: AppColors.aqua,
                        child: StreamBuilder(
                            stream: _editParentDetailController
                                .fetchParentShortNameStream(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return TextWidget(
                                  _editParentDetailController
                                      .getInitials(snapshot.data),
                                  styles: TextStyles.size36_700,
                                  color: AppColors.white,
                                );
                              } else {
                                return TextWidget('');
                              }
                            }),
                        radius: 50.r,
                      )),
                      SizedBox(
                        height: 12.h,
                      ),
                      StreamBuilder(
                          stream: _editParentDetailController
                              .fetchParentNameStream(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              // _editParentDetailController
                              //     .getInitials(snapshot.data);
                              return TextWidget(
                                snapshot.data ?? "",
                                styles: TextStyles.size24_600,
                                color: AppColors.white,
                              );
                            } else {
                              return TextWidget('');
                            }
                          }),
                      SizedBox(
                        height: 5.h,
                      ),
                      FutureBuilder(
                          future: Get.find<AppSharedPreferences>()
                              .getParentPhoneNumber(),
                          builder: (context, AsyncSnapshot snapshot) {
                            return TextWidget(
                              snapshot.data.toString(),
                              styles: TextStyles.size14_400,
                              color: AppColors.white,
                            );
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buildBody(context),
          ],
        ),
      ),
    );
  }
}

ChildrenDetailsController _childrenDetailController =
    Get.put(ChildrenDetailsController());

Widget buildBody(BuildContext context) => SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(23.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "Main Categories",
                styles: TextStyles.size16_700,
                color: const Color(0xff112950),
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  CustomContainerWithIcons(
                    color: const Color(0xffFD586B),
                    imgPath: "assets/images/Contact.png",
                    imgBackgroundColor: AppColors.white,
                    containerName: "Account       ",
                    onTap: () async {
                      await _childrenDetailController
                          .getChildrenDetailsInParentProfile(context);
                      var _pName = await Get.find<AppSharedPreferences>()
                          .getParentName();
                      var _pPhoneNumber = await Get.find<AppSharedPreferences>()
                          .getParentPhoneNumber();
                      Get.to(() => ParentAccount(
                            parentName: _pName.toString(),
                            parentPhone: _pPhoneNumber.toString(),
                          ));
                    },
                  ),
                  const Spacer(),
                  CustomContainerWithIcons(
                    color: AppColors.blue,
                    imgPath: "assets/images/Calendar.png",
                    imgBackgroundColor: const Color(0xffC8FBFF),
                    containerName: "Time Table    ",
                    onTap: () {
                      Get.to(() => const ParentTimeTable());
                    },
                  ),
                ],
              ),

              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  CustomContainerWithIcons(
                    color: Colors.green,
                    imgPath: "assets/images/visa.png",
                    imgBackgroundColor: AppColors.white,
                    containerName: "Payment method",
                    onTap: () {
                      Get.to(() => const PaymentMethodScreen());
                    },
                  ),
                  const Spacer(),
                  CustomContainerWithIcons(
                    color: const Color(0xff36DEED),
                    imgPath: "assets/images/Heart Rate.png",
                    imgBackgroundColor: AppColors.white,
                    containerName: "Library                 ",
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 35.h,
              ),
              Padding(
                padding: EdgeInsets.all(0.h),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const ContainerWithIConTextAndArrow(
                        text: "Edit Profile",
                        circleColor: Color(0xffFFCC00),
                        icon: Icons.save,
                      ),
                    ),
                    const Divider(),
                    const ContainerWithIConTextAndArrow(
                      text: "Rate us",
                      circleColor: Color(0xffFF8C00),
                      icon: Icons.star_border_outlined,
                    ),
                    const Divider(),
                    ContainerWithIConTextAndArrow(
                      text: "Settings",
                      circleColor: const Color(0xff000000),
                      icon: Icons.settings,
                      onTap: () {
                        Get.to(() => const ParentSettings());
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 84.h,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15.w),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           TextWidget(
              //             "Privacy    ",
              //             color: const Color(0xff666E7A),
              //             styles: TextStyles.size12_600,
              //           ),
              //           TextWidget(
              //             "|    ",
              //             color: const Color(0xff666E7A),
              //             styles: TextStyles.size12_600,
              //           ),
              //           TextWidget(
              //             "About Us   ",
              //             color: const Color(0xff666E7A),
              //             styles: TextStyles.size12_600,
              //           ),
              //           TextWidget(
              //             "|    ",
              //             color: const Color(0xff666E7A),
              //             styles: TextStyles.size12_600,
              //           ),
              //           TextWidget(
              //             "Logout   ",
              //             color: const Color(0xff666E7A),
              //             styles: TextStyles.size12_600,
              //           ),
              //         ],
              //       ),
              //       TextWidget(
              //         "App version 0.1",
              //         styles: TextStyles.size12_400,
              //         color: const Color(0xff666E7A),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
