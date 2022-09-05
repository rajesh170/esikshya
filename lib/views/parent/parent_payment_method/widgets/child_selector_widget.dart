import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esikshya/controllers/payment/payment_method_controller.dart';
import 'package:esikshya/controllers/payment_controller.dart';
import 'package:esikshya/db/database_helper.dart';
import 'package:esikshya/models/network_models/response/children_details_response.dart';
import 'package:esikshya/models/network_models/response/parent_child_details_response.dart';
import 'package:esikshya/utils/app_colors.dart';
import 'package:esikshya/views/parent/parent_payment_method/widgets/child_checkbox_widget.dart';

class ChildSelectorWidget extends StatelessWidget {
  const ChildSelectorWidget({
    Key? key,
    required this.isDarkModeOn,
    required DatabaseHelper db,
    required ParentPaymentController paymentController,
  })  : _db = db,
        _paymentController = paymentController,
        super(key: key);

  final bool isDarkModeOn;
  final DatabaseHelper _db;
  final ParentPaymentController _paymentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 150.h,
      ),
      margin: EdgeInsets.only(bottom: 2.h),
      color: isDarkModeOn ? AppColors.darkThemeCardColor : AppColors.white,
      child: Padding(
        // padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.h),
        padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
        child: FutureBuilder(
          // future: _db.getChildDetails(),
          future: _paymentController.fetchChildList(context),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // from db
              // List<ChildrenDetailsResponse> childList = snapshot.data;
              // from api
              List<ChildrenDetailsResponse> childList = snapshot.data;
              // childIdList
              childList.forEach((child) {
                _paymentController.childIdList.add(child.childId);
              });
              return StatefulBuilder(builder: (context, setState) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: childList.length,
                  itemBuilder: (context, index) {
                    return ChildElementCheckBox(
                      childModel: childList[index],
                      isDarkModeOn: isDarkModeOn,
                      value: _paymentController.childIdList
                          .contains(childList[index].childId),
                      onChanged: (value) {
                        setState(() {
                          if (_paymentController.childIdList
                              .contains(childList[index].childId)) {
                            _paymentController.childIdList
                                .remove(childList[index].childId);
                          } else {
                            _paymentController.childIdList
                                .add(childList[index].childId);
                          }
                          print(_paymentController.childIdList);
                        });
                      },
                    );
                  },
                );
              });
            }
            return Container(
                constraints: BoxConstraints(
                  maxHeight: 150.h,
                ),
                margin: EdgeInsets.only(bottom: 10.h),
                color: isDarkModeOn
                    ? AppColors.darkThemeCardColor
                    : AppColors.white,
                child: const Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
