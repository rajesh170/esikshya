// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sanduk/data/app_shared_preferences.dart';
// import 'package:sanduk/utils/app_colors.dart';
// import 'package:sanduk/utils/text_widget.dart';
// import 'package:sanduk/views/on_boarding/sanduk_choose_user_screen.dart';

// class OnTapPopDialog {
 
//   static openSandukDialog() {
//     Get.dialog(
//       AlertDialog(
//         titlePadding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25.r),
//         ),
//         title: SizedBox(
//           height: Get.height * 0.3,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: Get.height * 0.08,
//               ),
//               Expanded(
//                 child: TextWidget(
//                   "Are you sure you want\n to sign out?",
//                   styles: TextStyles.size20_600,
//                   color: AppColors.white,
//                   maxLines: 2,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const Spacer(),
//               Container(
//                 height: Get.height * 0.07,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(
//                       color: AppColors.greyText,
//                       width: 1.w,
//                     ),
//                     bottom: BorderSide(
//                       color: AppColors.transparent,
//                       width: 0.w,
//                     ),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       splashColor: AppColors.transparent,
//                       focusColor: AppColors.transparent,
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         height: Get.height * 0.07,
//                         width: Get.width * 0.39,
//                         decoration: BoxDecoration(
//                           border: Border(
//                             right: BorderSide(
//                               color: AppColors.greyText,
//                               width: 1.w,
//                             ),
//                           ),
//                         ),
//                         child: Center(
//                           child: TextWidget(
//                             "No",
//                             styles: TextStyles.size18_700,
//                             color: AppColors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       splashColor: AppColors.transparent,
//                       focusColor: AppColors.transparent,
//                       onTap: () async {
//                       await   _sharedPref.removeParentDetails();
//                         Get.offAll(() => const SandukChooseUserScreen());
//                       },
//                       child: SizedBox(
//                         height: Get.height * 0.07,
//                         width: Get.width * 0.39,
//                         child: Center(
//                           child: TextWidget(
//                             "Yes",
//                             styles: TextStyles.size18_700,
//                             color: AppColors.lightPink,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         backgroundColor: const Color(0xff484692),
//       ),
//       barrierColor: AppColors.darkThemeBackground.withOpacity(0.85),
//     );
//   }
// }
