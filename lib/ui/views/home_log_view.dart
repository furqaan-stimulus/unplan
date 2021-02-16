import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/ui/views/home_data_view.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/home_log_view_model.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/utils/date_time_format.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/widgets/break_button.dart';
import 'package:unplan/widgets/clock_out_button.dart';
import 'package:unplan/widgets/confirm_button.dart';

class HomeLogView extends StatefulWidget {
  @override
  _HomeLogViewState createState() => _HomeLogViewState();
}

class _HomeLogViewState extends State<HomeLogView> {
  double officeDist;
  double homeDist;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeLogViewModel>.reactive(
      viewModelBuilder: () => HomeLogViewModel(),
      onModelReady: (model) async {
        model.fetchLogs();
        model.getCurrentLocation();
        model.fetchAddress();
        model.initialise();
      },
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: ViewColor.background_purple_color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 35.0,
                  right: 35.0,
                  top: 40.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  child: FutureBuilder(
                    future: model.getLogType(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          decoration: BoxDecoration(color: ViewColor.background_white_color),
                        );
                      } else if (snapshot.data == null) {
                        return FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          color: (model.logType == null)
                              ? ViewColor.button_grey_color
                              : (model.logs.last.type == Utils.CLOCKIN)
                                  ? ViewColor.button_green_color
                                  : ViewColor.button_grey_color,
                          onPressed: () {
                            model.getCurrentLocation();
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                if (model.logType != null) {
                                  if (model.currentPosition == null) {
                                    return Center(child: Text(''));
                                  } else {
                                    officeDist = Geolocator.distanceBetween(
                                        double.parse((model.addressDetail.first.officeLatitude)),
                                        double.parse((model.addressDetail.first.officeLongitude)),
                                        model.currentPosition.latitude,
                                        model.currentPosition.longitude);
                                    homeDist = Geolocator.distanceBetween(
                                        double.parse((model.addressDetail.first.homeLatitude)),
                                        double.parse((model.addressDetail.first.homeLongitude)),
                                        model.currentPosition.latitude,
                                        model.currentPosition.longitude);
                                  }
                                } else {
                                  return Text('');
                                }
                                if (model.logType != null) {
                                  if (model.currentPosition == null) {
                                    return Container(
                                      height: 300,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(25.0),
                                          topRight: const Radius.circular(25.0),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: 300,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(25.0),
                                          topRight: const Radius.circular(25.0),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          (model.currentPosition != null)
                                              ? (officeDist <= 10.0)
                                                  ? SvgPicture.asset(
                                                      'assets/svg/office.svg',
                                                      height: 45,
                                                      width: 45,
                                                    )
                                                  : (homeDist <= 10.0)
                                                      ? SvgPicture.asset(
                                                          'assets/svg/home.svg',
                                                          height: 45,
                                                          width: 45,
                                                        )
                                                      : SvgPicture.asset(
                                                          'assets/svg/other.svg',
                                                          height: 45,
                                                          width: 45,
                                                        )
                                              : Text(''),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          (model.logType == null)
                                              ? Text(
                                                  'Logging out from',
                                                  style: TextStyles.buttonTextStyle2,
                                                )
                                              : (model.logType == Utils.CLOCKIN)
                                                  ? Text(
                                                      'Logging out from',
                                                      style: TextStyles.buttonTextStyle2,
                                                    )
                                                  : Text(
                                                      'You are',
                                                      style: TextStyles.buttonTextStyle2,
                                                    ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          (model.logs.last.type == Utils.CLOCKOUT ||
                                                  model.logs.last.type == Utils.TIMEOUT)
                                              ? (model.currentPosition != null)
                                                  ? (officeDist <= 10.0)
                                                      ? Text(
                                                          Utils.officeLocation,
                                                          style: TextStyles.bottomTextStyle,
                                                        )
                                                      : (homeDist <= 10.0)
                                                          ? Text(
                                                              Utils.homeLocation,
                                                              style: TextStyles.bottomTextStyle,
                                                            )
                                                          : Text(
                                                              Utils.unknownLocation,
                                                              style: TextStyles.bottomTextStyle,
                                                            )
                                                  : Text('')
                                              : (model.currentPosition != null)
                                                  ? (officeDist <= 10.0)
                                                      ? Text(
                                                          Utils.office,
                                                          style: TextStyles.bottomTextStyle,
                                                        )
                                                      : (homeDist <= 10.0)
                                                          ? Text(
                                                              Utils.home,
                                                              style: TextStyles.bottomTextStyle,
                                                            )
                                                          : Text(
                                                              Utils.unknown,
                                                              style: TextStyles.bottomTextStyle,
                                                            )
                                                  : Text(''),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          (model.currentPosition != null)
                                              ? (officeDist <= 10.0)
                                                  ? Text(
                                                      model.currentAddress,
                                                      style: TextStyles.bottomTextStyle2,
                                                    )
                                                  : (homeDist <= 10.0)
                                                      ? Text(
                                                          model.currentAddress,
                                                          style: TextStyles.bottomTextStyle2,
                                                        )
                                                      : Text(
                                                          model.currentAddress,
                                                          style: TextStyles.bottomTextStyle2,
                                                        )
                                              : Text(''),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          (model.logs.last.type == Utils.CLOCKOUT ||
                                                  model.logs.last.type == Utils.TIMEOUT)
                                              ? (DateTimeFormat.difference().inMinutes <= 5)
                                                  ? Text(
                                                      Utils.early,
                                                      style: TextStyles.bottomTextStyle3,
                                                    )
                                                  : (DateTimeFormat.difference().inMinutes <= 20)
                                                      ? Text(
                                                          Utils.late,
                                                          style: TextStyles.alertTextStyle,
                                                        )
                                                      : (DateTimeFormat.difference().inMinutes <= 60)
                                                          ? Text(
                                                              Utils.veryLate,
                                                              style: TextStyles.alertTextStyle1,
                                                            )
                                                          : (DateTimeFormat.difference().inMinutes <= 210)
                                                              ? Text(
                                                                  Utils.halfDay,
                                                                  style: TextStyles.alertTextStyle1,
                                                                )
                                                              : Text(
                                                                  'after half day',
                                                                  style: TextStyles.alertTextStyle1,
                                                                )
                                              : Text(''),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          (model.logs.last.type == Utils.CLOCKOUT ||
                                                  model.logs.last.type == Utils.TIMEOUT)
                                              ? ConfirmButton(
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
                                                )
                                              : Center(
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
                                                ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  return Container(
                                    height: 300,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: (model.logType == null)
                                ? Text(
                                    Utils.buttonIn,
                                    style: TextStyles.buttonTextStyle2,
                                  )
                                : (model.logs.last.type == Utils.CLOCKIN)
                                    ? Text(
                                        Utils.buttonOut,
                                        style: TextStyles.buttonTextStyle2,
                                      )
                                    : Text(
                                        Utils.buttonIn,
                                        style: TextStyles.buttonTextStyle2,
                                      ),
                          ),
                        );
                      } else {
                        return FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          color: (model.logType == null)
                              ? ViewColor.button_grey_color
                              : (model.logs.last.type == Utils.CLOCKIN)
                                  ? ViewColor.button_green_color
                                  : ViewColor.button_grey_color,
                          onPressed: () {
                            model.getCurrentLocation();
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                if (model.logType != null) {
                                  if (model.currentPosition == null) {
                                    return Center(child: Text(''));
                                  } else {
                                    officeDist = Geolocator.distanceBetween(
                                        double.parse((model.addressDetail.first.officeLatitude)),
                                        double.parse((model.addressDetail.first.officeLongitude)),
                                        model.currentPosition.latitude,
                                        model.currentPosition.longitude);
                                    homeDist = Geolocator.distanceBetween(
                                        double.parse((model.addressDetail.first.homeLatitude)),
                                        double.parse((model.addressDetail.first.homeLongitude)),
                                        model.currentPosition.latitude,
                                        model.currentPosition.longitude);
                                  }
                                } else {
                                  return Text('');
                                }
                                if (model.logType != null) {
                                  if (model.currentPosition == null) {
                                    return Container(
                                      height: 300,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(25.0),
                                          topRight: const Radius.circular(25.0),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: 300,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(25.0),
                                          topRight: const Radius.circular(25.0),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          (model.currentPosition != null)
                                              ? (officeDist <= 10.0)
                                                  ? SvgPicture.asset(
                                                      'assets/svg/office.svg',
                                                      height: 45,
                                                      width: 45,
                                                    )
                                                  : (homeDist <= 10.0)
                                                      ? SvgPicture.asset(
                                                          'assets/svg/home.svg',
                                                          height: 45,
                                                          width: 45,
                                                        )
                                                      : SvgPicture.asset(
                                                          'assets/svg/other.svg',
                                                          height: 45,
                                                          width: 45,
                                                        )
                                              : Text(''),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          (model.logType == null)
                                              ? Text(
                                                  'Logging out from',
                                                  style: TextStyles.buttonTextStyle2,
                                                )
                                              : (model.logType == Utils.CLOCKIN)
                                                  ? Text(
                                                      'Logging out from',
                                                      style: TextStyles.buttonTextStyle2,
                                                    )
                                                  : Text(
                                                      'You are',
                                                      style: TextStyles.buttonTextStyle2,
                                                    ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          (model.logType == Utils.CLOCKOUT || model.logType == Utils.CLOCKOUT)
                                              ? (model.currentPosition != null)
                                                  ? (officeDist <= 10.0)
                                                      ? Text(
                                                          Utils.officeLocation,
                                                          style: TextStyles.bottomTextStyle,
                                                        )
                                                      : (homeDist <= 10.0)
                                                          ? Text(
                                                              Utils.homeLocation,
                                                              style: TextStyles.bottomTextStyle,
                                                            )
                                                          : Text(
                                                              Utils.unknownLocation,
                                                              style: TextStyles.bottomTextStyle,
                                                            )
                                                  : Text('')
                                              : (model.currentPosition != null)
                                                  ? (officeDist <= 10.0)
                                                      ? Text(
                                                          Utils.office,
                                                          style: TextStyles.bottomTextStyle,
                                                        )
                                                      : (homeDist <= 10.0)
                                                          ? Text(
                                                              Utils.home,
                                                              style: TextStyles.bottomTextStyle,
                                                            )
                                                          : Text(
                                                              Utils.unknown,
                                                              style: TextStyles.bottomTextStyle,
                                                            )
                                                  : Text(''),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          (model.currentPosition != null)
                                              ? (officeDist <= 10.0)
                                                  ? Text(
                                                      model.currentAddress,
                                                      style: TextStyles.bottomTextStyle2,
                                                    )
                                                  : (homeDist <= 10.0)
                                                      ? Text(
                                                          model.currentAddress,
                                                          style: TextStyles.bottomTextStyle2,
                                                        )
                                                      : Text(
                                                          model.currentAddress,
                                                          style: TextStyles.bottomTextStyle2,
                                                        )
                                              : Text(''),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          (model.logs.last.type == Utils.CLOCKOUT ||
                                                  model.logs.last.type == Utils.TIMEOUT)
                                              ? (DateTimeFormat.difference().inMinutes <= 5)
                                                  ? Text(
                                                      Utils.early,
                                                      style: TextStyles.bottomTextStyle3,
                                                    )
                                                  : (DateTimeFormat.difference().inMinutes <= 20)
                                                      ? Text(
                                                          Utils.late,
                                                          style: TextStyles.alertTextStyle,
                                                        )
                                                      : (DateTimeFormat.difference().inMinutes <= 60)
                                                          ? Text(
                                                              Utils.veryLate,
                                                              style: TextStyles.alertTextStyle1,
                                                            )
                                                          : (DateTimeFormat.difference().inMinutes <= 210)
                                                              ? Text(
                                                                  Utils.halfDay,
                                                                  style: TextStyles.alertTextStyle1,
                                                                )
                                                              : Text(
                                                                  'after half day',
                                                                  style: TextStyles.alertTextStyle1,
                                                                )
                                              : Text(''),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          (model.logs.last.type == Utils.CLOCKOUT ||
                                                  model.logs.last.type == Utils.TIMEOUT)
                                              ? ConfirmButton(
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
                                                )
                                              : Center(
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
                                                ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  return Container(
                                    height: 300,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: (model.logs.length == null)
                                ? Text(
                                    Utils.buttonIn,
                                    style: TextStyles.buttonTextStyle2,
                                  )
                                : (model.logs.last.type == Utils.CLOCKIN)
                                    ? Text(
                                        Utils.buttonOut,
                                        style: TextStyles.buttonTextStyle2,
                                      )
                                    : Text(
                                        Utils.buttonIn,
                                        style: TextStyles.buttonTextStyle2,
                                      ),
                          ),
                        );
                      }
                    },
                  ),
                  // child: (model.hasError)
                  //     ? Container(
                  //         decoration: BoxDecoration(color: ViewColor.background_white_color),
                  //       )
                  //     : (model.logs.length == 0)
                  //         ? FlatButton(
                  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  //             color: (model.logType == null)
                  //                 ? ViewColor.button_grey_color
                  //                 : (model.logs.last.type == Utils.CLOCKIN)
                  //                     ? ViewColor.button_green_color
                  //                     : ViewColor.button_grey_color,
                  //             onPressed: () {
                  //               model.getCurrentLocation();
                  //               showModalBottomSheet(
                  //                 context: context,
                  //                 isScrollControlled: true,
                  //                 backgroundColor: Colors.transparent,
                  //                 builder: (context) {
                  //                   if (model.logType != null) {
                  //                     if (model.currentPosition == null) {
                  //                       return Center(child: Text(''));
                  //                     } else {
                  //                       officeDist = Geolocator.distanceBetween(
                  //                           double.parse((model.addressDetail.first.officeLatitude)),
                  //                           double.parse((model.addressDetail.first.officeLongitude)),
                  //                           model.currentPosition.latitude,
                  //                           model.currentPosition.longitude);
                  //                       homeDist = Geolocator.distanceBetween(
                  //                           double.parse((model.addressDetail.first.homeLatitude)),
                  //                           double.parse((model.addressDetail.first.homeLongitude)),
                  //                           model.currentPosition.latitude,
                  //                           model.currentPosition.longitude);
                  //                     }
                  //                   } else {
                  //                     return Text('');
                  //                   }
                  //                   if (model.logType != null) {
                  //                     if (model.currentPosition == null) {
                  //                       return Container(
                  //                         height: 300,
                  //                         decoration: new BoxDecoration(
                  //                           color: Colors.white,
                  //                           borderRadius: new BorderRadius.only(
                  //                             topLeft: const Radius.circular(25.0),
                  //                             topRight: const Radius.circular(25.0),
                  //                           ),
                  //                         ),
                  //                       );
                  //                     } else {
                  //                       return Container(
                  //                         height: 300,
                  //                         decoration: new BoxDecoration(
                  //                           color: Colors.white,
                  //                           borderRadius: new BorderRadius.only(
                  //                             topLeft: const Radius.circular(25.0),
                  //                             topRight: const Radius.circular(25.0),
                  //                           ),
                  //                         ),
                  //                         child: Column(
                  //                           crossAxisAlignment: CrossAxisAlignment.center,
                  //                           mainAxisAlignment: MainAxisAlignment.center,
                  //                           children: [
                  //                             (model.currentPosition != null)
                  //                                 ? (officeDist <= 10.0)
                  //                                     ? SvgPicture.asset(
                  //                                         'assets/svg/office.svg',
                  //                                         height: 45,
                  //                                         width: 45,
                  //                                       )
                  //                                     : (homeDist <= 10.0)
                  //                                         ? SvgPicture.asset(
                  //                                             'assets/svg/home.svg',
                  //                                             height: 45,
                  //                                             width: 45,
                  //                                           )
                  //                                         : SvgPicture.asset(
                  //                                             'assets/svg/other.svg',
                  //                                             height: 45,
                  //                                             width: 45,
                  //                                           )
                  //                                 : Text(''),
                  //                             SizedBox(
                  //                               height: 20.0,
                  //                             ),
                  //                             (model.logType == null)
                  //                                 ? Text(
                  //                                     'Logging out from',
                  //                                     style: TextStyles.buttonTextStyle2,
                  //                                   )
                  //                                 : (model.logType == Utils.CLOCKIN)
                  //                                     ? Text(
                  //                                         'Logging out from',
                  //                                         style: TextStyles.buttonTextStyle2,
                  //                                       )
                  //                                     : Text(
                  //                                         'You are',
                  //                                         style: TextStyles.buttonTextStyle2,
                  //                                       ),
                  //                             SizedBox(
                  //                               height: 5.0,
                  //                             ),
                  //                             (model.logs.last.type == Utils.CLOCKOUT ||
                  //                                     model.logs.last.type == Utils.TIMEOUT)
                  //                                 ? (model.currentPosition != null)
                  //                                     ? (officeDist <= 10.0)
                  //                                         ? Text(
                  //                                             Utils.officeLocation,
                  //                                             style: TextStyles.bottomTextStyle,
                  //                                           )
                  //                                         : (homeDist <= 10.0)
                  //                                             ? Text(
                  //                                                 Utils.homeLocation,
                  //                                                 style: TextStyles.bottomTextStyle,
                  //                                               )
                  //                                             : Text(
                  //                                                 Utils.unknownLocation,
                  //                                                 style: TextStyles.bottomTextStyle,
                  //                                               )
                  //                                     : Text('')
                  //                                 : (model.currentPosition != null)
                  //                                     ? (officeDist <= 10.0)
                  //                                         ? Text(
                  //                                             Utils.office,
                  //                                             style: TextStyles.bottomTextStyle,
                  //                                           )
                  //                                         : (homeDist <= 10.0)
                  //                                             ? Text(
                  //                                                 Utils.home,
                  //                                                 style: TextStyles.bottomTextStyle,
                  //                                               )
                  //                                             : Text(
                  //                                                 Utils.unknown,
                  //                                                 style: TextStyles.bottomTextStyle,
                  //                                               )
                  //                                     : Text(''),
                  //                             SizedBox(
                  //                               height: 5.0,
                  //                             ),
                  //                             (model.currentPosition != null)
                  //                                 ? (officeDist <= 10.0)
                  //                                     ? Text(
                  //                                         model.currentAddress,
                  //                                         style: TextStyles.bottomTextStyle2,
                  //                                       )
                  //                                     : (homeDist <= 10.0)
                  //                                         ? Text(
                  //                                             model.currentAddress,
                  //                                             style: TextStyles.bottomTextStyle2,
                  //                                           )
                  //                                         : Text(
                  //                                             model.currentAddress,
                  //                                             style: TextStyles.bottomTextStyle2,
                  //                                           )
                  //                                 : Text(''),
                  //                             SizedBox(
                  //                               height: 10.0,
                  //                             ),
                  //                             (model.logs.last.type == Utils.CLOCKOUT ||
                  //                                     model.logs.last.type == Utils.TIMEOUT)
                  //                                 ? (DateTimeFormat.difference().inMinutes <= 5)
                  //                                     ? Text(
                  //                                         Utils.early,
                  //                                         style: TextStyles.bottomTextStyle3,
                  //                                       )
                  //                                     : (DateTimeFormat.difference().inMinutes <= 20)
                  //                                         ? Text(
                  //                                             Utils.late,
                  //                                             style: TextStyles.alertTextStyle,
                  //                                           )
                  //                                         : (DateTimeFormat.difference().inMinutes <= 60)
                  //                                             ? Text(
                  //                                                 Utils.veryLate,
                  //                                                 style: TextStyles.alertTextStyle1,
                  //                                               )
                  //                                             : (DateTimeFormat.difference().inMinutes <= 210)
                  //                                                 ? Text(
                  //                                                     Utils.halfDay,
                  //                                                     style: TextStyles.alertTextStyle1,
                  //                                                   )
                  //                                                 : Text(
                  //                                                     'after half day',
                  //                                                     style: TextStyles.alertTextStyle1,
                  //                                                   )
                  //                                 : Text(''),
                  //                             SizedBox(
                  //                               height: 20.0,
                  //                             ),
                  //                             (model.logs.last.type == Utils.CLOCKOUT ||
                  //                                     model.logs.last.type == Utils.TIMEOUT)
                  //                                 ? ConfirmButton(
                  //                                     firstLog: true,
                  //                                     pressed: model.getLastLog(LogType.clockIn),
                  //                                     type: LogType.clockIn,
                  //                                     onPressed: () {
                  //                                       Navigator.of(context).pop();
                  //                                       model.markClockIn();
                  //                                       Flushbar(
                  //                                         messageText: Center(
                  //                                           child: Text(
                  //                                             Utils.msgClockIn,
                  //                                             style: TextStyles.notificationTextStyle1,
                  //                                           ),
                  //                                         ),
                  //                                         backgroundColor: ViewColor.notification_green_color,
                  //                                         flushbarPosition: FlushbarPosition.TOP,
                  //                                         flushbarStyle: FlushbarStyle.FLOATING,
                  //                                         duration: Duration(seconds: 2),
                  //                                       )..show(context);
                  //                                     },
                  //                                   )
                  //                                 : Center(
                  //                                     child: Row(
                  //                                       crossAxisAlignment: CrossAxisAlignment.center,
                  //                                       mainAxisAlignment: MainAxisAlignment.center,
                  //                                       children: [
                  //                                         BreakButton(
                  //                                           type: LogType.timeout,
                  //                                           firstLog: false,
                  //                                           pressed: model.getLastLog(LogType.timeout),
                  //                                           onPressed: () {
                  //                                             Navigator.of(context).pop();
                  //                                             model.markClockTimeOut();
                  //                                             Flushbar(
                  //                                               messageText: Center(
                  //                                                 child: Text(
                  //                                                   Utils.msgClockBreak,
                  //                                                   style: TextStyles.notificationTextStyle1,
                  //                                                 ),
                  //                                               ),
                  //                                               backgroundColor: ViewColor.notification_green_color,
                  //                                               flushbarPosition: FlushbarPosition.TOP,
                  //                                               flushbarStyle: FlushbarStyle.FLOATING,
                  //                                               duration: Duration(seconds: 2),
                  //                                             )..show(context);
                  //                                           },
                  //                                         ),
                  //                                         SizedBox(
                  //                                           width: 5.0,
                  //                                         ),
                  //                                         ClockOutButton(
                  //                                           firstLog: false,
                  //                                           type: LogType.clockOut,
                  //                                           pressed: model.getLastLog(LogType.clockOut),
                  //                                           onPressed: () {
                  //                                             Navigator.of(context).pop();
                  //                                             model.markClockOut();
                  //                                             Flushbar(
                  //                                               messageText: Center(
                  //                                                 child: Text(
                  //                                                   Utils.msgClockOut,
                  //                                                   style: TextStyles.notificationTextStyle1,
                  //                                                 ),
                  //                                               ),
                  //                                               backgroundColor: ViewColor.notification_green_color,
                  //                                               flushbarPosition: FlushbarPosition.TOP,
                  //                                               flushbarStyle: FlushbarStyle.FLOATING,
                  //                                               duration: Duration(seconds: 2),
                  //                                             )..show(context);
                  //                                           },
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                   ),
                  //                           ],
                  //                         ),
                  //                       );
                  //                     }
                  //                   } else {
                  //                     return Container(
                  //                       height: 300,
                  //                       decoration: new BoxDecoration(
                  //                         color: Colors.white,
                  //                         borderRadius: new BorderRadius.only(
                  //                           topLeft: const Radius.circular(25.0),
                  //                           topRight: const Radius.circular(25.0),
                  //                         ),
                  //                       ),
                  //                     );
                  //                   }
                  //                 },
                  //               );
                  //             },
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(15.0),
                  //               child: (model.logType == null)
                  //                   ? Text(
                  //                       Utils.buttonIn,
                  //                       style: TextStyles.buttonTextStyle2,
                  //                     )
                  //                   : (model.logs.last.type == Utils.CLOCKIN)
                  //                       ? Text(
                  //                           Utils.buttonOut,
                  //                           style: TextStyles.buttonTextStyle2,
                  //                         )
                  //                       : Text(
                  //                           Utils.buttonIn,
                  //                           style: TextStyles.buttonTextStyle2,
                  //                         ),
                  //             ),
                  //           )
                  //         : FlatButton(
                  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  //             color: (model.logType == null)
                  //                 ? ViewColor.button_grey_color
                  //                 : (model.logs.last.type == Utils.CLOCKIN)
                  //                     ? ViewColor.button_green_color
                  //                     : ViewColor.button_grey_color,
                  //             onPressed: () {
                  //               model.getCurrentLocation();
                  //               showModalBottomSheet(
                  //                 context: context,
                  //                 isScrollControlled: true,
                  //                 backgroundColor: Colors.transparent,
                  //                 builder: (context) {
                  //                   if (model.logType != null) {
                  //                     if (model.currentPosition == null) {
                  //                       return Center(child: Text(''));
                  //                     } else {
                  //                       officeDist = Geolocator.distanceBetween(
                  //                           double.parse((model.addressDetail.first.officeLatitude)),
                  //                           double.parse((model.addressDetail.first.officeLongitude)),
                  //                           model.currentPosition.latitude,
                  //                           model.currentPosition.longitude);
                  //                       homeDist = Geolocator.distanceBetween(
                  //                           double.parse((model.addressDetail.first.homeLatitude)),
                  //                           double.parse((model.addressDetail.first.homeLongitude)),
                  //                           model.currentPosition.latitude,
                  //                           model.currentPosition.longitude);
                  //                     }
                  //                   } else {
                  //                     return Text('');
                  //                   }
                  //                   if (model.logType != null) {
                  //                     if (model.currentPosition == null) {
                  //                       return Container(
                  //                         height: 300,
                  //                         decoration: new BoxDecoration(
                  //                           color: Colors.white,
                  //                           borderRadius: new BorderRadius.only(
                  //                             topLeft: const Radius.circular(25.0),
                  //                             topRight: const Radius.circular(25.0),
                  //                           ),
                  //                         ),
                  //                       );
                  //                     } else {
                  //                       return Container(
                  //                         height: 300,
                  //                         decoration: new BoxDecoration(
                  //                           color: Colors.white,
                  //                           borderRadius: new BorderRadius.only(
                  //                             topLeft: const Radius.circular(25.0),
                  //                             topRight: const Radius.circular(25.0),
                  //                           ),
                  //                         ),
                  //                         child: Column(
                  //                           crossAxisAlignment: CrossAxisAlignment.center,
                  //                           mainAxisAlignment: MainAxisAlignment.center,
                  //                           children: [
                  //                             (model.currentPosition != null)
                  //                                 ? (officeDist <= 10.0)
                  //                                     ? SvgPicture.asset(
                  //                                         'assets/svg/office.svg',
                  //                                         height: 45,
                  //                                         width: 45,
                  //                                       )
                  //                                     : (homeDist <= 10.0)
                  //                                         ? SvgPicture.asset(
                  //                                             'assets/svg/home.svg',
                  //                                             height: 45,
                  //                                             width: 45,
                  //                                           )
                  //                                         : SvgPicture.asset(
                  //                                             'assets/svg/other.svg',
                  //                                             height: 45,
                  //                                             width: 45,
                  //                                           )
                  //                                 : Text(''),
                  //                             SizedBox(
                  //                               height: 20.0,
                  //                             ),
                  //                             (model.logType == null)
                  //                                 ? Text(
                  //                                     'Logging out from',
                  //                                     style: TextStyles.buttonTextStyle2,
                  //                                   )
                  //                                 : (model.logType == Utils.CLOCKIN)
                  //                                     ? Text(
                  //                                         'Logging out from',
                  //                                         style: TextStyles.buttonTextStyle2,
                  //                                       )
                  //                                     : Text(
                  //                                         'You are',
                  //                                         style: TextStyles.buttonTextStyle2,
                  //                                       ),
                  //                             SizedBox(
                  //                               height: 5.0,
                  //                             ),
                  //                             (model.logType == Utils.CLOCKOUT || model.logType == Utils.CLOCKOUT)
                  //                                 ? (model.currentPosition != null)
                  //                                     ? (officeDist <= 10.0)
                  //                                         ? Text(
                  //                                             Utils.officeLocation,
                  //                                             style: TextStyles.bottomTextStyle,
                  //                                           )
                  //                                         : (homeDist <= 10.0)
                  //                                             ? Text(
                  //                                                 Utils.homeLocation,
                  //                                                 style: TextStyles.bottomTextStyle,
                  //                                               )
                  //                                             : Text(
                  //                                                 Utils.unknownLocation,
                  //                                                 style: TextStyles.bottomTextStyle,
                  //                                               )
                  //                                     : Text('')
                  //                                 : (model.currentPosition != null)
                  //                                     ? (officeDist <= 10.0)
                  //                                         ? Text(
                  //                                             Utils.office,
                  //                                             style: TextStyles.bottomTextStyle,
                  //                                           )
                  //                                         : (homeDist <= 10.0)
                  //                                             ? Text(
                  //                                                 Utils.home,
                  //                                                 style: TextStyles.bottomTextStyle,
                  //                                               )
                  //                                             : Text(
                  //                                                 Utils.unknown,
                  //                                                 style: TextStyles.bottomTextStyle,
                  //                                               )
                  //                                     : Text(''),
                  //                             SizedBox(
                  //                               height: 5.0,
                  //                             ),
                  //                             (model.currentPosition != null)
                  //                                 ? (officeDist <= 10.0)
                  //                                     ? Text(
                  //                                         model.currentAddress,
                  //                                         style: TextStyles.bottomTextStyle2,
                  //                                       )
                  //                                     : (homeDist <= 10.0)
                  //                                         ? Text(
                  //                                             model.currentAddress,
                  //                                             style: TextStyles.bottomTextStyle2,
                  //                                           )
                  //                                         : Text(
                  //                                             model.currentAddress,
                  //                                             style: TextStyles.bottomTextStyle2,
                  //                                           )
                  //                                 : Text(''),
                  //                             SizedBox(
                  //                               height: 10.0,
                  //                             ),
                  //                             (model.logs.last.type == Utils.CLOCKOUT ||
                  //                                     model.logs.last.type == Utils.TIMEOUT)
                  //                                 ? (DateTimeFormat.difference().inMinutes <= 5)
                  //                                     ? Text(
                  //                                         Utils.early,
                  //                                         style: TextStyles.bottomTextStyle3,
                  //                                       )
                  //                                     : (DateTimeFormat.difference().inMinutes <= 20)
                  //                                         ? Text(
                  //                                             Utils.late,
                  //                                             style: TextStyles.alertTextStyle,
                  //                                           )
                  //                                         : (DateTimeFormat.difference().inMinutes <= 60)
                  //                                             ? Text(
                  //                                                 Utils.veryLate,
                  //                                                 style: TextStyles.alertTextStyle1,
                  //                                               )
                  //                                             : (DateTimeFormat.difference().inMinutes <= 210)
                  //                                                 ? Text(
                  //                                                     Utils.halfDay,
                  //                                                     style: TextStyles.alertTextStyle1,
                  //                                                   )
                  //                                                 : Text(
                  //                                                     'after half day',
                  //                                                     style: TextStyles.alertTextStyle1,
                  //                                                   )
                  //                                 : Text(''),
                  //                             SizedBox(
                  //                               height: 20.0,
                  //                             ),
                  //                             (model.logs.last.type == Utils.CLOCKOUT ||
                  //                                     model.logs.last.type == Utils.TIMEOUT)
                  //                                 ? ConfirmButton(
                  //                                     firstLog: true,
                  //                                     pressed: model.getLastLog(LogType.clockIn),
                  //                                     type: LogType.clockIn,
                  //                                     onPressed: () {
                  //                                       Navigator.of(context).pop();
                  //                                       model.markClockIn();
                  //                                       Flushbar(
                  //                                         messageText: Center(
                  //                                           child: Text(
                  //                                             Utils.msgClockIn,
                  //                                             style: TextStyles.notificationTextStyle1,
                  //                                           ),
                  //                                         ),
                  //                                         backgroundColor: ViewColor.notification_green_color,
                  //                                         flushbarPosition: FlushbarPosition.TOP,
                  //                                         flushbarStyle: FlushbarStyle.FLOATING,
                  //                                         duration: Duration(seconds: 2),
                  //                                       )..show(context);
                  //                                     },
                  //                                   )
                  //                                 : Center(
                  //                                     child: Row(
                  //                                       crossAxisAlignment: CrossAxisAlignment.center,
                  //                                       mainAxisAlignment: MainAxisAlignment.center,
                  //                                       children: [
                  //                                         BreakButton(
                  //                                           type: LogType.timeout,
                  //                                           firstLog: false,
                  //                                           pressed: model.getLastLog(LogType.timeout),
                  //                                           onPressed: () {
                  //                                             Navigator.of(context).pop();
                  //                                             model.markClockTimeOut();
                  //                                             Flushbar(
                  //                                               messageText: Center(
                  //                                                 child: Text(
                  //                                                   Utils.msgClockBreak,
                  //                                                   style: TextStyles.notificationTextStyle1,
                  //                                                 ),
                  //                                               ),
                  //                                               backgroundColor: ViewColor.notification_green_color,
                  //                                               flushbarPosition: FlushbarPosition.TOP,
                  //                                               flushbarStyle: FlushbarStyle.FLOATING,
                  //                                               duration: Duration(seconds: 2),
                  //                                             )..show(context);
                  //                                           },
                  //                                         ),
                  //                                         SizedBox(
                  //                                           width: 5.0,
                  //                                         ),
                  //                                         ClockOutButton(
                  //                                           firstLog: false,
                  //                                           type: LogType.clockOut,
                  //                                           pressed: model.getLastLog(LogType.clockOut),
                  //                                           onPressed: () {
                  //                                             Navigator.of(context).pop();
                  //                                             model.markClockOut();
                  //                                             Flushbar(
                  //                                               messageText: Center(
                  //                                                 child: Text(
                  //                                                   Utils.msgClockOut,
                  //                                                   style: TextStyles.notificationTextStyle1,
                  //                                                 ),
                  //                                               ),
                  //                                               backgroundColor: ViewColor.notification_green_color,
                  //                                               flushbarPosition: FlushbarPosition.TOP,
                  //                                               flushbarStyle: FlushbarStyle.FLOATING,
                  //                                               duration: Duration(seconds: 2),
                  //                                             )..show(context);
                  //                                           },
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                   ),
                  //                           ],
                  //                         ),
                  //                       );
                  //                     }
                  //                   } else {
                  //                     return Container(
                  //                       height: 300,
                  //                       decoration: new BoxDecoration(
                  //                         color: Colors.white,
                  //                         borderRadius: new BorderRadius.only(
                  //                           topLeft: const Radius.circular(25.0),
                  //                           topRight: const Radius.circular(25.0),
                  //                         ),
                  //                       ),
                  //                     );
                  //                   }
                  //                 },
                  //               );
                  //             },
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(15.0),
                  //               child: (model.logs.length == null)
                  //                   ? Text(
                  //                       Utils.buttonIn,
                  //                       style: TextStyles.buttonTextStyle2,
                  //                     )
                  //                   : (model.logs.last.type == Utils.CLOCKIN)
                  //                       ? Text(
                  //                           Utils.buttonOut,
                  //                           style: TextStyles.buttonTextStyle2,
                  //                         )
                  //                       : Text(
                  //                           Utils.buttonIn,
                  //                           style: TextStyles.buttonTextStyle2,
                  //                         ),
                  //             ),
                  //           ),
                ),
              ),
              Container(height: 100, child: HomeDataView()),
            ],
          ),
        ),
      ),
    );
  }
}
