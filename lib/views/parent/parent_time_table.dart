import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/dark_mode_controller.dart';
import 'package:esikshya/controllers/fetch_time_table_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/add_time_table/add_time_table.dart';

class ParentTimeTable extends StatelessWidget {
  const ParentTimeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    FetchTimeTableController _fetchTimeTableController =
        Get.put(FetchTimeTableController());
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isDarkModeOn ? AppColors.darkThemeBackground : AppColors.white,
        appBar: CustomAppBar(
          title: "Time Table",
          leadingIcon: Icons.arrow_back,
          appBarBackgroundColor:
              isDarkModeOn ? AppColors.darkThemeBackground : AppColors.white,
          centerTitle: true,
          txtColor: isDarkModeOn ? AppColors.white : AppColors.black,
          iconColor: isDarkModeOn ? AppColors.white : AppColors.black,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddTimeTableScreen());
          },
          child: Icon(Icons.add, size: 25.sp, color: AppColors.white),
          backgroundColor: AppColors.darkBlue,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: FutureBuilder(
              future: _fetchTimeTableController.fetchTimeTable(context),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextWidget(
                                    _fetchTimeTableController.currentDay.value,
                                    styles: TextStyles.size16_500,
                                    color: isDarkModeOn
                                        ? AppColors.greyText
                                        : AppColors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_fetchTimeTableController
                                            .currentWeekday.value !=
                                        0) {
                                      _fetchTimeTableController
                                          .currentWeekday.value--;
                                      _fetchTimeTableController
                                          .changeCurrentDay();
                                    }
                                  },
                                  child: Container(
                                    height: 30.h,
                                    width: 30.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isDarkModeOn
                                            ? AppColors.white
                                            : AppColors.black,
                                        width: 1.w,
                                      ),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        size: 20.sp,
                                        color: isDarkModeOn
                                            ? AppColors.greyText
                                            : AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    _fetchTimeTableController
                                        .currentWeekday.value++;
                                    _fetchTimeTableController
                                        .changeCurrentDay();
                                  },
                                  child: Container(
                                    height: 30.h,
                                    width: 30.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isDarkModeOn
                                            ? AppColors.white
                                            : AppColors.black,
                                        width: 1.w,
                                      ),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        size: 20.sp,
                                        color: isDarkModeOn
                                            ? AppColors.greyText
                                            : AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            ListView.builder(
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return snapshot.data[index].day ==
                                          _fetchTimeTableController
                                              .currentDay.value
                                      ? Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 0, 0, 10.h),
                                          child: TimeTableCard(
                                            startingTime: snapshot
                                                .data[index].startTime
                                                .toString()
                                                .substring(0, 5),
                                            endTime: snapshot
                                                .data[index].endTime
                                                .toString()
                                                .substring(0, 5),
                                            subjectName: snapshot
                                                .data[index].description
                                                .toString(),
                                            seperatorColor: index.isEven
                                                ? AppColors.blue
                                                : index % 3 == 0
                                                    ? AppColors.aqua
                                                    : AppColors.lightPink,
                                          ),
                                        )
                                      : const SizedBox();
                                }),

                            // SizedBox(
                            //   height: 10.h,
                            // ),
                            // const TimeTableCard(
                            //   startingTime: "11 : 00",
                            //   endTime: "12 : 45",
                            //   subjectName: "Science",
                            //   seperatorColor: AppColors.lightGreen,
                            // ),
                            // SizedBox(
                            //   height: 10.h,
                            // ),
                            // const TimeTableCard(
                            //   startingTime: "09 : 00",
                            //   endTime: "10 : 45",
                            //   subjectName: "Maths",
                            //   seperatorColor: AppColors.lightPink,
                            // ),
                            // SizedBox(
                            //   height: 10.h,
                            // ),
                            // const TimeTableCard(
                            //   startingTime: "11 : 00",
                            //   endTime: "12 : 45",
                            //   subjectName: "Science",
                            //   seperatorColor: AppColors.aqua,
                            // ),
                          ],
                        ),
                      )
                    : TextWidget("No Data");
              }),
        ),
      ),
    );
  }
}

class TimeTableCard extends StatelessWidget {
  const TimeTableCard({
    Key? key,
    required this.seperatorColor,
    required this.startingTime,
    required this.endTime,
    required this.subjectName,
  }) : super(key: key);
  final Color seperatorColor;
  final String startingTime;
  final String endTime;
  final String subjectName;

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = Get.find<DarkModecontroller>().isDarkModeOn.value;
    return Card(
      elevation: 3.h,
      margin: EdgeInsets.zero,
      color: isDarkModeOn ? AppColors.darkThemeCardColor : AppColors.white,
      child: Container(
        // height: 140.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: isDarkModeOn ? AppColors.darkThemeCardColor : AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      startingTime,
                      styles: TextStyles.size16_400,
                      color: isDarkModeOn ? AppColors.white : AppColors.black,
                    ),
                    TextWidget(
                      endTime,
                      styles: TextStyles.size12_400,
                      color: AppColors.greyText,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  height: 25.h,
                  width: 1.5.w,
                  color: seperatorColor,
                ),
                SizedBox(
                  width: 20.w,
                ),
                TextWidget(
                  subjectName,
                  styles: TextStyles.size12_400,
                  color: seperatorColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
