import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';

import 'package:unplan/view_models/leave_list_log_view_model.dart';
import 'package:unplan/widgets/leave_list_item.dart';

class LeaveListLogView extends StatefulWidget {
  @override
  _LeaveListLogViewState createState() => _LeaveListLogViewState();
}

class _LeaveListLogViewState extends State<LeaveListLogView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaveListLogViewModel>.reactive(
      viewModelBuilder: () => LeaveListLogViewModel(),
      onModelReady: (model) {
        model.isInternet();
        model.initialise();
      },
      builder: (context, model, child) => MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: model.leaveList.length,
          itemBuilder: (context, index) {
            if (model.leaveList.length == 0) {
              return Center(
                child: Container(
                  child: Text(
                    "No Data",
                    style: TextStyles.alertTextStyle1,
                  ),
                ),
              );
            } else {
              return LeaveListItem(
                log: model.leaveList[index],
              );
            }
          },
        ),
      ),
    );
  }
}
