import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esikshya/models/network_models/response/children_details_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ChildElementCheckBox extends StatelessWidget {
  const ChildElementCheckBox({
    Key? key,
    required this.childModel,
    required this.isDarkModeOn,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final ChildrenDetailsResponse childModel;
  final bool isDarkModeOn;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("pressed");
        onChanged!(!value);
      },
      child: Padding(
        // padding: const EdgeInsets.all(8.0),
        padding: EdgeInsets.all(3.h),
        child: Row(
          children: [
            Expanded(
              child: TextWidget(
                "Child:  ${childModel.username} ",
                styles: TextStyles.size12_400,
                color: isDarkModeOn ? AppColors.white : AppColors.black,
              ),
            ),
            Checkbox(
              activeColor: AppColors.aqua,
              focusColor: AppColors.white,
              fillColor: MaterialStateProperty.all(AppColors.aqua),
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
