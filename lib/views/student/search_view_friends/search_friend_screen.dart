import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/student/friend_request_send_accept_view_controller.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';

class SearchFriendScreen extends StatelessWidget {
  const SearchFriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    FriendRequestSendAcceptViewController _friendController =
        Get.put(FriendRequestSendAcceptViewController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          backgroundColor: AppColors.lightPink,
          elevation: 0,
          toolbarHeight: 70.h,
          title: Row(
            children: [
              TextWidget("Add a Friend", color: AppColors.white),
              const Spacer(),
              InkWell(
                  onTap: () async {
                    await _friendController.sendFriendRequest(
                        context, _friendController.receiverId.value);
                  },
                  child: TextWidget("Send Request", color: AppColors.white)),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70.h,
                  child: CupertinoSearchTextField(
                    //  itemSize: widget.itemSize,
                    placeholder: "Search username",
                    placeholderStyle: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                    padding: EdgeInsets.only(top: 2.h, left: 5.h, bottom: 4.h),
                    controller: _searchController,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 12.sp,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                    ),
                    itemColor: AppColors.lightPink,
                    autocorrect: false,
                    backgroundColor: Colors.white,
                    // padding: EdgeInsets.only(bottom: 0.05.h),
                    onChanged: (value) {
                      _friendController.hasPerformedSearch.value = false;
                    },
                    onSubmitted: (value) async {
                      log(value);
                      _friendController.hasPerformedSearch.value = true;
                      _friendController.parameters.value = value;
                      await _friendController.searchFriends(value, context);
                    },
                  ),
                ),
                Obx(
                  () => _friendController.hasPerformedSearch.value
                      ? _friendController.isLoading.value
                          ? const CircularProgressIndicator(
                              color: AppColors.lightPink,
                            )
                          : _friendController.temp.isNotEmpty &&
                                  _friendController.hasPerformedSearch.value
                              ? ListView.builder(
                                  itemCount: _friendController.temp.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => SearchResultItems(
                                        name:
                                            _friendController.temp[index].name,
                                        value: _friendController
                                                .receiverId.value ==
                                            _friendController.temp[index].id,
                                        onChanged: (val) {
                                          if (_friendController
                                                  .receiverId.value ==
                                              _friendController
                                                  .temp[index].id) {
                                            _friendController.receiverId.value =
                                                0;
                                          } else {
                                            _friendController.receiverId.value =
                                                _friendController
                                                    .temp[index].id;
                                          }
                                          log(_friendController.receiverId.value
                                              .toString());
                                        },
                                      ),
                                    );
                                  },
                                )
                              : TextWidget("No data")
                      : const SizedBox(),
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
    required this.name,
    required this.value,
    this.onChanged,
  }) : super(key: key);
  final String name;
  final bool value;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: CheckboxListTile(
          value: value,
          onChanged: onChanged,
          title: TextWidget(
            name,
            maxLines: 2,
          ),
        ));
  }
}
