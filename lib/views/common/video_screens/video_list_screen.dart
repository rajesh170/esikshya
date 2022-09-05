import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:esikshya/controllers/fetch_video_list_by_subject_controller.dart';
import 'package:esikshya/models/network_models/response/videos_response/fectch_videos_by_class_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/utils/text_widget.dart';
import 'package:esikshya/views/common/video_screens/video_screen.dart';

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({Key? key, required this.subject}) : super(key: key);
  final String subject;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  elevation: 1.h,
                  expandedHeight: 220.h,
                  collapsedHeight: 25.h,
                  toolbarHeight: 0.h,
                  automaticallyImplyLeading: true,
                  backgroundColor: AppColors.lightPink,
                  pinned: true,
                  bottom: TabBar(
                    indicatorPadding: EdgeInsets.symmetric(
                      horizontal: 15.h,
                    ),
                    indicatorColor: AppColors.white,
                    unselectedLabelColor: AppColors.white.withOpacity(0.8),
                    unselectedLabelStyle: TextStyle(
                      color: AppColors.greyText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Montserrat",
                    ),
                    labelColor: AppColors.white,
                    labelStyle: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Montserrat",
                    ),
                    tabs: const [
                      Text("Courses"),
                      Text("Skill up"),
                      // Text("Watching"),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    // title: TextWidget(
                    //   "My Courses",
                    //   styles: TextStyles.size18_700,
                    //   color: AppColors.white,
                    // ),
                    titlePadding: EdgeInsets.only(bottom: 25.h),
                    background: Container(
                      color: AppColors.lightPink,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.lightPink,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          TextWidget(
                            "My Courses",
                            styles: TextStyles.size18_700,
                            color: AppColors.white,
                          ),
                          TextWidget(
                            "Start learning today's most in-demand skills for free",
                            styles: TextStyles.size12_400,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(children: [
              ViewCoursesScreen(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                subject: subject,
              ),
              Container(
                height: screenHeight,
                width: screenWidth,
                color: AppColors.white,
              ),
            ])),
      )),
    );
  }
}

class ViewCoursesScreen extends StatelessWidget {
  const ViewCoursesScreen({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.subject,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String subject;

  @override
  Widget build(BuildContext context) {
    FetchVideoListBySubjectController _vLController =
        Get.put(FetchVideoListBySubjectController());
    return SingleChildScrollView(
      child: Container(
        color: AppColors.white.withOpacity(0.8),
        child: Column(
          children: [
            FutureBuilder(
              future: _vLController.fetchVideosBySubject(context, "SCIENCE", 5),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          FetchVideoByClassResponse _vResponse =
                              snapshot.data[index];

                          return InkWell(
                            onTap: () {
                              Get.to(() => VideoPlayerScreen(
                                    id: _vLController.youtubeIdToShow[index]
                                        .toString(),
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 10.h),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // FutureBuilder(
                                        //     future: _vLController
                                        //         .getYoutubeVideoDetails(
                                        //             _vLController
                                        //                     .youtubeUrlToshow[
                                        //                 index]),
                                        //     builder: (context,
                                        //         AsyncSnapshot snapshot) {
                                        //       if (snapshot.hasData) {
                                        //         YoutubeDetailsResponse
                                        //             youtubeDetailsResponse =
                                        //             snapshot.data;
                                        //         return TextWidget(
                                        //           youtubeDetailsResponse.title
                                        //               .toString(),
                                        //           styles: TextStyles.size12_400,
                                        //           color: AppColors.black,
                                        //           maxLines: 2,
                                        //         );
                                        //       } else {
                                        //         return TextWidget("");
                                        //       }
                                        //     }),
                                        TextWidget(
                                          _vLController.temp[index].title
                                              .toString(),
                                          styles: TextStyles.size14_500,
                                          maxLines: 2,
                                        ),
                                        TextWidget(
                                          _vResponse.topic.toString(),
                                          styles: TextStyles.size14_500,
                                          maxLines: 2,
                                        ),
                                        TextWidget(
                                          _vResponse.subject.toString(),
                                          styles: TextStyles.size12_400,
                                          color: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.network(
                                      // 'https://img.youtube.com/vi/${_vLController.youtubeIdToShow[index].toString()}/0.jpg',
                                      _vLController.temp[index].thumbnailUrl
                                          .toString(),
                                      height: 70.h,
                                      width: 100.w,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: TextWidget(
                        "No Videos Available for this subject",
                        styles: TextStyles.size12_400,
                        color: AppColors.red,
                      ),
                    );
                  }
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.lightPink,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
