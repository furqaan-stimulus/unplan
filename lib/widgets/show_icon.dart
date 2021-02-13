import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/view_models/attendance_log_control_view_model.dart';

class ShowIcon extends ViewModelBuilderWidget<AttendanceLogControlViewModel> {
  final double officeDist;
  final double homeDist;

  const ShowIcon({Key key, this.homeDist, this.officeDist})
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

      return GestureDetector(
        onTap: () {
          model.getCurrentLocation();
          model.getAddressFromLatLng();
        },
        child: SvgPicture.asset(
          "assets/svg/other.svg",
          height: 45,
          width: 45,
        ),
      );
    } else if (officeDist <= 10.0) {

      return GestureDetector(
        onTap: () {
          model.getCurrentLocation();
          model.getAddressFromLatLng();
        },
        child: SvgPicture.asset(
          'assets/svg/office.svg',
          height: 45,
          width: 45,
        ),
      );
    } else if (homeDist <= 10.0) {

      return GestureDetector(
        onTap: () {
          model.getCurrentLocation();
          model.getAddressFromLatLng();
        },
        child: SvgPicture.asset(
          'assets/svg/home.svg',
          height: 45,
          width: 45,
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          model.getCurrentLocation();
          model.getAddressFromLatLng();
        },
        child: SvgPicture.asset(
          'assets/svg/other.svg',
          height: 45,
          width: 45,
        ),
      );
    }
  }

  @override
  AttendanceLogControlViewModel viewModelBuilder(BuildContext context) => AttendanceLogControlViewModel();
}
