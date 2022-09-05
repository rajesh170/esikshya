import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:esikshya/controllers/bottom_nav_bar_controller.dart';
import 'package:esikshya/controllers/notification_screen_controller.dart';
import 'package:esikshya/controllers/student/friend_request_send_accept_view_controller.dart';
import 'package:esikshya/custom_widgets/k_app_bar.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/models/network_models/response/game_notification_response.dart';
import 'package:esikshya/models/network_models/response/notification_screen_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/student/quiz_with_friends/quiz_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key, required this.isUserChild})
      : super(key: key);
  final bool isUserChild;

  @override
  Widget build(BuildContext context) {
    FriendRequestSendAcceptViewController _friendController =
        Get.put(FriendRequestSendAcceptViewController());
    NotificationScreenController _notificationScreenController =
        Get.put(NotificationScreenController());
    BottomNavController _bottomController = Get.put(BottomNavController());
    log("Notification Screen");
    return Scaffold(
        appBar: const CustomAppBar(
          appBarBackgroundColor: AppColors.lightPink,
          title: "Notifications",
          centerTitle: true,
          // leadingIcon: Icons.arrow_back,
          // iconColor: AppColors.white,
          // onTapBack: () {
          //   Get.back();
          // },
        ),
        body: Obx(
          () => _bottomController.changeStateOfNotification.value
              ? _friendController.hasPerformedAcceptOrReject.value
                  ? isUserChild
                      ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NormalNotificationWidget(
                                friendController: _friendController,
                                notificationScreenController:
                                    _notificationScreenController,
                              ),
                              SizedBox(height: 10.h),

                              //-------- For game Notification-----//
                              GameNotificationWidget(
                                notificationScreenController:
                                    _notificationScreenController,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox()
                  : const SizedBox()
              : const SizedBox(),
        ));
  }
}

class GameNotificationWidget extends StatelessWidget {
  const GameNotificationWidget(
      {Key? key, required this.notificationScreenController})
      : super(key: key);
  final NotificationScreenController notificationScreenController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: notificationScreenController.getChildGameNotification(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    GameNotificationResponse _gameNotificationResponse =
                        snapshot.data[index];
                    return InkWell(
                      onTap: () async {
                        var childAccessToken =
                            await Get.find<AppSharedPreferences>()
                                .getChildAccessToken();

                        await notificationScreenController
                            .removeChildGameNotification(
                                context, _gameNotificationResponse.id);

                        Get.to(
                          () => QuizScreen(
                            connectivityStatus:
                                _gameNotificationResponse.status!,
                            childAccessToken: childAccessToken!,
                            grade: _gameNotificationResponse.grade!,
                            opponentId: _gameNotificationResponse.oponentId!,
                            subjectName: _gameNotificationResponse.subject!,
                            title: _gameNotificationResponse.title!,
                            isFromNotificationScreen: true,
                            isWithRandom: false,
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              _gameNotificationResponse.description.toString(),
                              styles: TextStyles.size12_700,
                            ),
                            TextWidget(
                              // _gameNotificationResponse.createdAt.toString(),
                              DateFormat.yMMMd().add_jm().format(DateTime.parse(
                                    _gameNotificationResponse.createdAt
                                        .toString(),
                                  )),
                              styles: TextStyles.size10_500,
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return TextWidget(
                "No data",
                styles: TextStyles.size14_500,
              );
            }
          } else {
            return TextWidget("loading...");
          }
        });
  }
}

class NormalNotificationWidget extends StatelessWidget {
  const NormalNotificationWidget(
      {Key? key,
      required this.notificationScreenController,
      required this.friendController})
      : super(key: key);
  final NotificationScreenController notificationScreenController;
  final FriendRequestSendAcceptViewController friendController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: notificationScreenController.getChildNotification(context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    NotificationResponse _notificationResponse =
                        snapshot.data[index];
                    if (_notificationResponse.type.toString() ==
                        "friendrequest") {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            _notificationResponse.description.toString(),
                            styles: TextStyles.size14_500,
                          ),
                          TextWidget(
                            // _notificationResponse.createdAt.toString(),
                            DateFormat('dd-MM-yyyy HH:mm:ss').format(
                                DateTime.parse(_notificationResponse.createdAt
                                    .toString())),
                            styles: TextStyles.size14_500,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await friendController.acceptFriendRequest(
                                      context,
                                      _notificationResponse.secondaryUserId!,
                                      _notificationResponse.id!);
                                },
                                child: TextWidget("Accept"),
                              ),
                              SizedBox(width: 15.w),
                              InkWell(
                                onTap: () async {
                                  await friendController.rejectFriendRequest(
                                      context,
                                      _notificationResponse.secondaryUserId!,
                                      _notificationResponse.id!);
                                },
                                child: TextWidget("Reject"),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            _notificationResponse.description.toString(),
                            styles: TextStyles.size14_500,
                          ),
                          TextWidget(
                            _notificationResponse.createdAt.toString(),
                            styles: TextStyles.size14_500,
                          ),
                          SizedBox(height: 15.h),
                        ],
                      );
                    }
                  });
            } else {
              return TextWidget(
                "No data",
                styles: TextStyles.size14_500,
              );
            }
          } else {
            return TextWidget("loading...");
          }
        });
  }
}
