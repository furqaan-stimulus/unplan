import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/view_models/attendance_log_control_view_model.dart';

class ShowLocation extends ViewModelBuilderWidget<AttendanceLogControlViewModel> {
  final double officeDist;
  final double homeDist;

  const ShowLocation({Key key, this.homeDist, this.officeDist})
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
    if (model.hasError) {
      return Text("there is some error");
    } else if ((model.currentPosition == null) && (model.logs.length == 0)) {
      return Text(
        '',
        style: TextStyles.buttonTextStyle2,
      );
    } else if ((model.currentPosition != null) && (model.logs.length == 0)) {
      if (officeDist <= 10.0) {
        return Text(
          Utils.officeLocation,
          style: TextStyles.bottomTextStyle,
        );
      } else if (homeDist <= 10.0) {
        return Text(
          Utils.homeLocation,
          style: TextStyles.bottomTextStyle,
        );
      } else {
        return Text(
          Utils.unknownLocation,
          style: TextStyles.bottomTextStyle,
        );
      }
    } else if (model.logType == Utils.CLOCKIN) {
      if (officeDist <= 10.0) {
        return Text(
          Utils.office,
          style: TextStyles.bottomTextStyle,
        );
      } else if (homeDist <= 10.0) {
        return Text(
          Utils.home,
          style: TextStyles.bottomTextStyle,
        );
      } else {
        return Text(
          Utils.unknown,
          style: TextStyles.bottomTextStyle,
        );
      }
    } else {
      if (officeDist <= 10.0) {
        return Text(
          Utils.officeLocation,
          style: TextStyles.bottomTextStyle,
        );
      } else if (homeDist <= 10.0) {
        return Text(
          Utils.homeLocation,
          style: TextStyles.bottomTextStyle,
        );
      } else {
        return Text(
          Utils.unknownLocation,
          style: TextStyles.bottomTextStyle,
        );
      }
    }
  }

  @override
  AttendanceLogControlViewModel viewModelBuilder(BuildContext context) => AttendanceLogControlViewModel();
}
