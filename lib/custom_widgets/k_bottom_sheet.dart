import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {Key? key,
      required this.title,
      this.subTitle,
      required this.items,
      required this.bottomSheetHeading,
      this.storeTo,
      this.height,
      this.width,
      this.border,
      this.containerColor,
      this.storedValue})
      : super(key: key);

  final List items;
  final double? height;
  final double? width;
  final String title;
  final String? subTitle;
  final Rx? storeTo;
  final String? bottomSheetHeading;
  final BoxBorder? border;
  final Color? containerColor;
  final String? storedValue;

  /// this is  to define color for selected item

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        Get.bottomSheet(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: AppColors.scaffoldColor,
                    width: 2.h,
                  ))),
                  child: TextWidget(
                    bottomSheetHeading!,
                    styles: TextStyles.size14_400,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            storeTo!.value = items[index];
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 15.w),
                            child: Row(
                              children: [
                                Container(
                                  height: 8.h,
                                  width: 8.h,
                                  decoration: BoxDecoration(
                                    border: storedValue == items[index]
                                        ? null
                                        : Border.all(
                                            width: 0.5.sp,
                                            color: AppColors.black),
                                    color: storedValue == items[index]
                                        ? AppColors.aqua
                                        : AppColors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 15.h,
                                ),
                                TextWidget(
                                  items[index].toString(),
                                  styles: TextStyles.size12_400,
                                  color: AppColors.darkGrey,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            backgroundColor: AppColors.white);
      },
      child: Container(
        width: width ?? Get.width,
        height: height ?? 55.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: containerColor ?? AppColors.backgroundGrey,
          borderRadius: border == null ? BorderRadius.circular(5.r) : null,
          border: border,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                TextWidget(
                  title,
                  styles: TextStyles.size12_400,
                  color: AppColors.darkGrey,
                ),
                const Spacer(),
                Icon(
                  Icons.expand_more_sharp,
                  size: 20.sp,
                ),
              ],
            ),
            SizedBox(height: 5.h),
            subTitle == null
                ? const SizedBox()
                : TextWidget(
                    subTitle ?? "",
                    styles: TextStyles.size14_400,
                    color: AppColors.black,
                  ),
          ],
        ),
      ),
    );
  }
}
