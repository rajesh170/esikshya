import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? txtColor;
  final Color? iconColor;
  final Color? appBarBackgroundColor;
  final void Function()? onTapBack;
  final void Function()? onTapCancel;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool? needContainerForIcons;
  final bool? centerTitle;
  final double? toolBarHeight;
  final double? elevation;
  final Gradient? gradient;
  final double? iconSize;

  const CustomAppBar({
    Key? key,
    this.title,
    this.txtColor,
    this.appBarBackgroundColor,
    this.leadingIcon,
    this.trailingIcon,
    this.onTapBack,
    this.onTapCancel,
    this.needContainerForIcons,
    this.centerTitle,
    this.toolBarHeight,
    this.elevation,
    this.gradient,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight ?? 70.h);

  @override
  Widget build(BuildContext context) {
    return
        // PreferredSize(
        //     child: Container(
        //       height: 70.h,
        //       // padding: EdgeInsets.symmetric(horizontal: 5.h),
        //       decoration: BoxDecoration(
        //         gradient: gradient,
        //         color: appBarBackgroundColor ?? AppColors.lightYellow,
        //       ),
        //       child: Row(
        //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           leadingIcon == null
        //               ? SizedBox(
        //                   height: 26.h,
        //                   width: 26.h,
        //                 )
        //               : InkWell(
        //                   onTap: onTapBack,
        //                   child: Container(
        //                     height: 26.h,
        //                     width: 26.h,
        //                     padding: EdgeInsets.only(left: 8.w),
        //                     child: Center(
        //                       child: Icon(
        //                         leadingIcon,
        //                         color: iconColor ?? AppColors.white,
        //                         size: 15.sp,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //           const Spacer(),
        //           Expanded(
        //             flex: 0,
        //             child: TextWidget(
        //               title!,
        //               styles: TextStyles.size18_600,
        //               color: txtColor ?? AppColors.white,
        //             ),
        //           ),
        //           const Spacer(),
        //           trailingIcon != null
        //               ? InkWell(
        //                   onTap: onTapCancel,
        //                   child: SizedBox(
        //                     height: 26.h,
        //                     width: 26.h,
        //                     child: Icon(
        //                       trailingIcon,
        //                       color: AppColors.white,
        //                       size: 15.sp,
        //                     ),
        //                   ),
        //                 )
        //               : const SizedBox(),
        //         ],
        //       ),
        //     ),
        //     preferredSize: preferredSize);

        AppBar(
      leadingWidth: 40.w,
      backgroundColor: appBarBackgroundColor ?? AppColors.transparent,
      elevation: elevation ?? 0.h,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle ?? true,
      toolbarHeight: toolBarHeight ?? 70.h,
      actions: [
        trailingIcon != null
            ? InkWell(
                onTap: onTapCancel,
                child: Center(
                  child: Icon(
                    trailingIcon,
                    color: iconColor ?? AppColors.white,
                    size: iconSize ?? 15.sp,
                  ),
                ),
              )
            : const SizedBox(),
        SizedBox(
          width: 10.h,
        ),
      ],
      leading: leadingIcon == null
          ? null
          : InkWell(
              onTap: onTapBack ??
                  () {
                    Navigator.pop(context);
                  },
              child: Container(
                height: 26.h,
                width: 26.h,
                padding: EdgeInsets.only(left: 8.w),
                decoration: needContainerForIcons == false
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        // color: Color(0xffF5F6F7),
                        color: AppColors.transparent,
                      ),
                child: Center(
                  child: Icon(
                    leadingIcon,
                    color: iconColor ?? AppColors.black,
                    size: iconSize ?? 20.sp,
                  ),
                ),
              ),
            ),
      title: TextWidget(
        title ?? "",
        styles: TextStyles.size18_600,
        color: txtColor ?? AppColors.white,
      ),
    );
  }
}
