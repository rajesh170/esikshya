import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/add_time_table_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/custom_widgets/k_bottom_sheet.dart';
import 'package:esikshya/custom_widgets/k_button_widget.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/app_constants_list.dart';
import 'package:esikshya/utils/app_widgets.dart';
import 'package:esikshya/utils/text_widget.dart';

class AddTimeTableScreen extends StatelessWidget {
  const AddTimeTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddTimeTableController _addTimeTableController = AddTimeTableController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          appBarBackgroundColor: AppColors.white,
          title: "Subject & Time Table",
          txtColor: AppColors.black,
          centerTitle: false,
          trailingIcon: Icons.close,
          iconSize: 25.sp,
          iconColor: AppColors.black,
          gradient: AppColors.peachGradient,
          onTapCancel: () {
            Navigator.pop(context);
          },
          // leadingIcon: Icons.arrow_back_ios,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            // padding: screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      SizedBox(
                        height: Get.height * 0.6,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 15.w),
                                width: Get.width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.scaffoldColor,
                                      width: 2.w,
                                    ),
                                  ),
                                ),
                                child: TextWidget(
                                  "Select Subject",
                                  styles: TextStyles.size14_400,
                                ),
                              ),
                              ListView.builder(
                                  itemCount: AppConstantsList.subjects.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        _addTimeTableController
                                                .selectedSubject.value =
                                            AppConstantsList.subjects[index];
                                        Get.back();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.h, horizontal: 15.w),
                                        width: Get.width,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 8.h,
                                              width: 8.h,
                                              decoration: BoxDecoration(
                                                border: _addTimeTableController
                                                            .selectedSubject
                                                            .value ==
                                                        AppConstantsList
                                                            .subjects[index]
                                                    ? null
                                                    : Border.all(
                                                        width: 0.5.sp,
                                                        color: AppColors.black),
                                                color: _addTimeTableController
                                                            .selectedSubject
                                                            .value ==
                                                        AppConstantsList
                                                            .subjects[index]
                                                    ? AppColors.aqua
                                                    : AppColors.transparent,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.h,
                                            ),
                                            TextWidget(
                                              AppConstantsList.subjects[index]
                                                  .toString(),
                                              styles: TextStyles.size12_400,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                      ),
                      backgroundColor: AppColors.white,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: AppColors.darkGrey, width: 1.sp),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          "Subject",
                          styles: TextStyles.size15_600,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Obx(
                          () => TextWidget(
                            _addTimeTableController.selectedSubject.value == ""
                                ? "Geography"
                                : _addTimeTableController.selectedSubject.value,
                            styles: TextStyles.size12_400,
                            color:
                                _addTimeTableController.selectedSubject.value ==
                                        ""
                                    ? AppColors.greyText
                                    : AppColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          "CLASS",
                          styles: TextStyles.size12_600,
                          color: AppColors.greyText,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Obx(
                          () => CustomBottomSheet(
                            width: Get.width * 0.45,
                            height: 40.h,
                            title: _addTimeTableController
                                        .selectedClass.value ==
                                    "0"
                                ? "--"
                                : _addTimeTableController.selectedClass.value
                                    .toString(),
                            items: AppConstantsList.grade,
                            bottomSheetHeading: "Select Class",
                            storeTo: _addTimeTableController.selectedClass,
                            storedValue: _addTimeTableController
                                .selectedClass.value
                                .toString(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          "SECTION",
                          styles: TextStyles.size12_600,
                          color: AppColors.greyText,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Obx(
                          () => CustomBottomSheet(
                            width: Get.width * 0.45,
                            height: 40.h,
                            title: _addTimeTableController
                                        .selectedSection.value ==
                                    ""
                                ? "--"
                                : _addTimeTableController.selectedSection.value,
                            items: AppConstantsList.section,
                            bottomSheetHeading: "SECTION",
                            storeTo: _addTimeTableController.selectedSection,
                            storedValue:
                                _addTimeTableController.selectedSection.value,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextWidget(
                  "DESCRIPTION",
                  styles: TextStyles.size12_600,
                  color: AppColors.greyText,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Obx(
                  () => CustomBottomSheet(
                    width: Get.width,
                    height: 40.h,
                    title: _addTimeTableController.selectedPeriod.value == ""
                        ? "--"
                        : _addTimeTableController.selectedPeriod.value,
                    items: AppConstantsList.period,
                    bottomSheetHeading: "Description",
                    storeTo: _addTimeTableController.selectedPeriod,
                    storedValue: _addTimeTableController.selectedPeriod.value,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextWidget(
                  "DAYS",
                  styles: TextStyles.size12_600,
                  color: AppColors.greyText,
                ),
                SizedBox(
                  height: 5.h,
                ),
                DaysTimeRoutineContainer(
                  days: AppConstantsList.days,
                  addTimeTableController: _addTimeTableController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ButtonWidget(
                  width: Get.width,
                  onPressed: () async {
                    if (_addTimeTableController.selectedSubject.value == "") {
                      AppWidgets.showSnackBar(context, "Select Subject");
                    } else if (_addTimeTableController.selectedClass.value ==
                        0) {
                      AppWidgets.showSnackBar(context, "Select Class");
                    } else if (_addTimeTableController.selectedSection.value ==
                        "") {
                      AppWidgets.showSnackBar(context, "Select Section");
                    } else if (_addTimeTableController.selectedPeriod.value ==
                        "") {
                      AppWidgets.showSnackBar(context, "Select Descriptions");
                    } else if (_addTimeTableController.selectedTime.value ==
                        "") {
                      AppWidgets.showSnackBar(context, "Select Start Time");
                    } else if (_addTimeTableController.endTime.value == "") {
                      AppWidgets.showSnackBar(context, "Select End Time");
                    } else if (_addTimeTableController.selectedDay == []) {
                      AppWidgets.showSnackBar(context, "Select Day");
                    } else {
                      await _addTimeTableController.addTimeTable(context);
                    }
                  },
                  buttonText: "Done",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DaysTimeRoutineContainer extends StatelessWidget {
  const DaysTimeRoutineContainer({
    Key? key,
    required List<String> days,
    required AddTimeTableController addTimeTableController,
  })  : _days = days,
        _addTimeTableController = addTimeTableController,
        super(key: key);

  final List<String> _days;
  final AddTimeTableController _addTimeTableController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _days.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Obx(
                  () => Expanded(
                    child: CheckboxListTile(
                      value: _addTimeTableController.selectedDay
                          .contains(AppConstantsList.days[index]),
                      onChanged: (value) {
                        if (_addTimeTableController.selectedDay
                            .contains(AppConstantsList.days[index])) {
                          _addTimeTableController.selectedDay
                              .remove(AppConstantsList.days[index]);
                          _addTimeTableController.resetTime();
                        } else {
                          _addTimeTableController.selectedDay.value = [];
                          _addTimeTableController.resetTime();
                          _addTimeTableController.selectedDay
                              .add(AppConstantsList.days[index]);
                          _addTimeTableController.selectedIndex.value = index;

                          DatePicker.showTime12hPicker(context,
                              showTitleActions: true,
                              onChanged: (time) {}, onConfirm: (time) {
                            _addTimeTableController.selectedTime.value =
                                time.toString().substring(11, 19);

                            DatePicker.showTime12hPicker(
                              context,
                              showTitleActions: true,
                              onChanged: (time) {},
                              onConfirm: (timeEnd) {
                                _addTimeTableController.endTime.value =
                                    timeEnd.toString().substring(11, 19);
                              },
                              theme: DatePickerTheme(
                                  backgroundColor:
                                      AppColors.darkThemeBackground,
                                  containerHeight: 250,
                                  cancelStyle: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16.sp,
                                  ),
                                  doneStyle: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16.sp,
                                  ),
                                  itemStyle: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20.sp,
                                  )),
                              currentTime: DateTime.now(),
                              locale: LocaleType.en,
                            );
                          },
                              theme: const DatePickerTheme(
                                backgroundColor: AppColors.white,
                                containerHeight: 250,
                              ),
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }
                      },
                      title: Row(
                        children: [
                          TextWidget(_days[index]),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.h,
                            ),
                            child: Row(
                              children: [
                                Obx(() =>
                                    // index == 0
                                    //     ?
                                    TextWidget(
                                      _addTimeTableController
                                                  .selectedIndex.value ==
                                              index
                                          ? _addTimeTableController
                                              .selectedTime.value
                                          : "Choose time",
                                      styles: TextStyles.size10_600,
                                      color: AppColors.black,
                                    )),
                                Obx(() =>
                                    // index == 0
                                    //     ?
                                    TextWidget(
                                      _addTimeTableController
                                                  .selectedIndex.value ==
                                              index
                                          ? "- ${_addTimeTableController.endTime.value.toString()}"
                                          : "-",
                                      styles: TextStyles.size10_600,
                                      color: AppColors.black,
                                    )),
                                SizedBox(
                                  width: 15.h,
                                ),
                                Icon(
                                  Icons.schedule,
                                  size: 20.sp,
                                  color: AppColors.darkGrey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      checkColor: AppColors.white,
                      activeColor: AppColors.checkBoxColor,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

// index == 0
//     ? _addTimeTableController.sunday.value =
//         time.toString().substring(10, 16.sp)
//     : index == 1
//         ? _addTimeTableController.monday.value =
//             time.toString().substring(10, 16.sp)
//         : index == 2
//             ? _addTimeTableController.tuesday.value =
//                 time.toString().substring(10, 16.sp)
//             : index == 3
//                 ? _addTimeTableController.wednesday.value = time
//                     .toString()
//                     .substring(10, 16.sp)
//                 : index == 4
//                     ? _addTimeTableController.thursday.value = time
//                         .toString()
//                         .substring(10, 16.sp)
//                     : index == 5
//                         ? _addTimeTableController.friday.value = time
//                             .toString()
//                             .substring(10, 16.sp)
//                         : _addTimeTableController
//                             .saturday
//                             .value = time.toString().substring(10, 16.sp);

// : index == 1
//     ? TextWidget(
//         _addTimeTableController
//                     .monday.value ==
//                 ""
//             ? "Choose time"
//             : _addTimeTableController
//                 .monday.value,
//         styles: TextStyles.size10_600,
//         color: AppColors.black,
//       )
//     : index == 2
//         ? TextWidget(
//             _addTimeTableController
//                         .tuesday.value ==
//                     ""
//                 ? "Choose time"
//                 : _addTimeTableController
//                     .tuesday.value,
//             styles: TextStyles.size10_600,
//             color: AppColors.black,
//           )
//         : index == 3
//             ? TextWidget(
//                 _addTimeTableController
//                             .wednesday
//                             .value ==
//                         ""
//                     ? "Choose time"
//                     : _addTimeTableController
//                         .wednesday.value,
//                 styles:
//                     TextStyles.size10_600,
//                 color: AppColors.black,
//               )
//             : index == 4
//                 ? TextWidget(
//                     _addTimeTableController
//                                 .thursday
//                                 .value ==
//                             ""
//                         ? "Choose time"
//                         : _addTimeTableController
//                             .thursday
//                             .value,
//                     styles: TextStyles
//                         .size10_600,
//                     color:
//                         AppColors.black,
//                   )
//                 : index == 5
//                     ? TextWidget(
//                         _addTimeTableController
//                                     .friday
//                                     .value ==
//                                 ""
//                             ? "Choose time"
//                             : _addTimeTableController
//                                 .friday
//                                 .value,
//                         styles: TextStyles
//                             .size10_600,
//                         color: AppColors
//                             .black,
//                       )
//                     : TextWidget(
//                         _addTimeTableController
//                                     .saturday
//                                     .value ==
//                                 ""
//                             ? "Choose time"
//                             : _addTimeTableController
//                                 .saturday
//                                 .value,
//                         styles: TextStyles
//                             .size10_600,
//                         color: AppColors
//                             .black,
// ),
