import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/attendance_log_control_view_model.dart';
import 'package:unplan/widgets/break_button.dart';
import 'package:unplan/widgets/clock_out_button.dart';
import 'package:unplan/widgets/confirm_button.dart';

class ShowLogButtons extends ViewModelBuilderWidget<AttendanceLogControlViewModel> {
  final double officeDist;
  final double homeDist;

  const ShowLogButtons({Key key, this.homeDist, this.officeDist}) : super(key: key);

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
      return ConfirmButton(
        firstLog: true,
        pressed: model.getLastLog(LogType.clockIn),
        type: LogType.clockIn,
        onPressed: () {
          Navigator.of(context).pop();
          model.markClockIn();
          Flushbar(
            messageText: Center(
              child: Text(
                Utils.msgClockIn,
                style: TextStyles.notificationTextStyle1,
              ),
            ),
            backgroundColor: ViewColor.notification_green_color,
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.FLOATING,
            duration: Duration(seconds: 2),
          )..show(context);
        },
      );
    } else {
      return Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BreakButton(
              type: LogType.timeout,
              firstLog: false,
              pressed: model.getLastLog(LogType.timeout),
              onPressed: () {
                Navigator.of(context).pop();
                model.markClockTimeOut();
                Flushbar(
                  messageText: Center(
                    child: Text(
                      Utils.msgClockBreak,
                      style: TextStyles.notificationTextStyle1,
                    ),
                  ),
                  backgroundColor: ViewColor.notification_green_color,
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.FLOATING,
                  duration: Duration(seconds: 2),
                )..show(context);
              },
            ),
            SizedBox(
              width: 5.0,
            ),
            ClockOutButton(
              firstLog: false,
              type: LogType.clockOut,
              pressed: model.getLastLog(LogType.clockOut),
              onPressed: () {
                Navigator.of(context).pop();
                model.markClockOut();
                Flushbar(
                  messageText: Center(
                    child: Text(
                      Utils.msgClockOut,
                      style: TextStyles.notificationTextStyle1,
                    ),
                  ),
                  backgroundColor: ViewColor.notification_green_color,
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.FLOATING,
                  duration: Duration(seconds: 2),
                )..show(context);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  AttendanceLogControlViewModel viewModelBuilder(BuildContext context) => AttendanceLogControlViewModel();
}
