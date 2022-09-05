import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esikshya/controllers/payment/payment_method_controller.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class GeneralWidget extends StatelessWidget {
  const GeneralWidget({
    Key? key,
    required this.widgetTitle,
    required this.isDarkModeOn,
    required this.childWidget,
  }) : super(key: key);

  final String widgetTitle;
  final bool isDarkModeOn;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          TextWidget(
            widgetTitle,
            styles: TextStyles.size16_500,
            color: isDarkModeOn ? AppColors.white : AppColors.black,
          ),
          childWidget,
        ],
      ),
    );
  }
}
