import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class ViewAllFriendsScreen extends StatelessWidget {
  const ViewAllFriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const SearchResultItems();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchResultItems extends StatelessWidget {
  const SearchResultItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.red,
            radius: 25.r,
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: TextWidget(
              "Hari Sharma hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh",
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
