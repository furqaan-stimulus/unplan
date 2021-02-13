import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/date_time_format.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/view_models/attendance_log_control_view_model.dart';

class ShowTimeDifference extends ViewModelBuilderWidget<AttendanceLogControlViewModel> {
  final double officeDist;
  final double homeDist;

  const ShowTimeDifference({Key key, this.homeDist, this.officeDist})
      : super(
          key: key,
        );

  @override
  bool get reactive => true;

  @override
  void onViewModelReady(model) {
    model.initialise();
    model.getLogType();
    model.getCurrentLocation();
    model.getAddressFromLatLng();
    model.fetchLogs();
    model.fetchAddress();
  }

  @override
  bool get createNewModelOnInsert => true;

  @override
  Widget builder(BuildContext context, AttendanceLogControlViewModel model, Widget child) {
    if (model.logs.length == 0) {
      if (model.logType == Utils.CLOCKOUT || model.logType == Utils.TIMEOUT) {
        if (DateTimeFormat.difference().inMinutes <= 5) {
          return Text(
            Utils.early,
            style: TextStyles.bottomTextStyle3,
          );
        } else if (DateTimeFormat.difference().inMinutes <= 20) {
          return Text(
            Utils.late,
            style: TextStyles.alertTextStyle,
          );
        } else if (DateTimeFormat.difference().inMinutes <= 60) {
          return Text(
            Utils.veryLate,
            style: TextStyles.alertTextStyle1,
          );
        } else if (DateTimeFormat.difference().inMinutes <= 210) {
          return Text(
            Utils.halfDay,
            style: TextStyles.alertTextStyle1,
          );
        } else {
          return Text(
            'after half day',
            style: TextStyles.alertTextStyle1,
          );
        }
      } else {
        return Text('');
      }
    } else {
      return Text('');
    }
  }

  @override
  AttendanceLogControlViewModel viewModelBuilder(BuildContext context) => AttendanceLogControlViewModel();
}
