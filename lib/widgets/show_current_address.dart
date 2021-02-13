import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/view_models/attendance_log_control_view_model.dart';

class ShowCurrentAddress extends ViewModelBuilderWidget<AttendanceLogControlViewModel> {
  final double officeDist;
  final double homeDist;

  const ShowCurrentAddress({Key key, this.homeDist, this.officeDist})
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
      return Text('');
    } else if ((model.currentPosition != null) && (model.logs.length == 0)) {
      return Text(
        "${model.currentAddress}",
        style: TextStyles.bottomTextStyle2,
      );
    } else if (double.parse((model.addressDetail.first.officeLatitude)) == 0 &&
            double.parse((model.addressDetail.first.officeLongitude)) == 0 ||
        double.parse((model.addressDetail.first.homeLatitude)) == 0 &&
            double.parse((model.addressDetail.first.homeLongitude)) == 0) {
      if (officeDist <= 10.0) {
        return Text(
          "${model.currentAddress}",
          style: TextStyles.bottomTextStyle2,
        );
      } else if (homeDist <= 10.0) {
        return Text(
          "${model.currentAddress}",
          style: TextStyles.bottomTextStyle2,
        );
      } else {
        return Text(
          "${model.currentAddress}",
          style: TextStyles.bottomTextStyle2,
        );
      }
    } else {
      if (officeDist <= 10.0) {
        return Text(
          "${model.currentAddress}",
          style: TextStyles.bottomTextStyle2,
        );
      } else if (homeDist <= 10.0) {
        return Text(
          "${model.currentAddress}",
          style: TextStyles.bottomTextStyle2,
        );
      } else {
        return Text(
          "${model.currentAddress}",
          style: TextStyles.bottomTextStyle2,
        );
      }
    }
  }

  @override
  AttendanceLogControlViewModel viewModelBuilder(BuildContext context) => AttendanceLogControlViewModel();
}
