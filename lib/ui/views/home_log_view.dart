import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/ui/views/home_data_view.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/home_log_view_model.dart';
import 'package:unplan/widgets/break_button.dart';
import 'package:unplan/widgets/clock_out_button.dart';
import 'package:unplan/widgets/confirm_button.dart';

class HomeLogView extends StatefulWidget {
  @override
  _HomeLogViewState createState() => _HomeLogViewState();
}

class _HomeLogViewState extends State<HomeLogView> {
  bool isClicked = true;

  void _isBtnClicked() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime notificationDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 30, 00);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    return ViewModelBuilder<HomeLogViewModel>.reactive(
      viewModelBuilder: () => HomeLogViewModel(),
      fireOnModelReadyOnce: true,
      onModelReady: (model) async {
        model.getCurrentLocation();
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
                    builder: (context, snapLog) {
                      if (snapLog.hasData) {
                        return FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          color:
                              (snapLog.data == 'clock-in') ? ViewColor.button_green_color : ViewColor.button_grey_color,
                          onPressed: () {
                            model.getCurrentLocation();
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
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
                                        ? (model.officeLat ==
                                                    double.parse((model.currentPosition.latitude).toStringAsFixed(2)) &&
                                                model.officeLong ==
                                                    double.parse((model.currentPosition.longitude).toStringAsFixed(2)))
                                            ? SvgPicture.asset(
                                                'assets/svg/office.svg',
                                                height: 45,
                                                width: 45,
                                              )
                                            : (model.homeLat ==
                                                        double.parse(
                                                            (model.currentPosition.latitude).toStringAsFixed(2)) &&
                                                    model.homeLong ==
                                                        double.parse(
                                                            (model.currentPosition.latitude).toStringAsFixed(2)))
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
                                    (snapLog.data == 'clock-in')
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
                                    (snapLog.data == 'clock-out' || snapLog.data == 'break')
                                        ? (model.currentPosition != null)
                                            ? (model.officeLat ==
                                                        double.parse(
                                                            (model.currentPosition.latitude).toStringAsFixed(2)) &&
                                                    model.officeLong ==
                                                        double.parse(
                                                            (model.currentPosition.longitude).toStringAsFixed(2)))
                                                ? Text(
                                                    'At Stimulus HQ',
                                                    style: TextStyles.bottomTextStyle,
                                                  )
                                                : (model.homeLat ==
                                                            double.parse(
                                                                (model.currentPosition.latitude).toStringAsFixed(2)) &&
                                                        model.homeLong ==
                                                            double.parse(
                                                                (model.currentPosition.latitude).toStringAsFixed(2)))
                                                    ? Text(
                                                        'Working From Home',
                                                        style: TextStyles.bottomTextStyle,
                                                      )
                                                    : Text(
                                                        'At Unknown Place',
                                                        style: TextStyles.bottomTextStyle,
                                                      )
                                            : Text('')
                                        : (model.currentPosition != null)
                                            ? (model.officeLat ==
                                                        double.parse(
                                                            (model.currentPosition.latitude).toStringAsFixed(2)) &&
                                                    model.officeLong ==
                                                        double.parse(
                                                            (model.currentPosition.longitude).toStringAsFixed(2)))
                                                ? Text(
                                                    'Office',
                                                    style: TextStyles.bottomTextStyle,
                                                  )
                                                : (model.homeLat ==
                                                            double.parse(
                                                                (model.currentPosition.latitude).toStringAsFixed(2)) &&
                                                        model.homeLong ==
                                                            double.parse(
                                                                (model.currentPosition.latitude).toStringAsFixed(2)))
                                                    ? Text(
                                                        'Home',
                                                        style: TextStyles.bottomTextStyle,
                                                      )
                                                    : Text(
                                                        'Other',
                                                        style: TextStyles.bottomTextStyle,
                                                      )
                                            : Text(''),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    (model.currentPosition != null)
                                        ? (model.officeLat ==
                                                    double.parse((model.currentPosition.latitude).toStringAsFixed(3)) &&
                                                model.officeLong ==
                                                    double.parse((model.currentPosition.latitude).toStringAsFixed(3)))
                                            ? Text(
                                                model.currentAddress,
                                                style: TextStyles.bottomTextStyle2,
                                              )
                                            : (model.homeLat ==
                                                        double.parse(
                                                            (model.currentPosition.latitude).toStringAsFixed(3)) &&
                                                    model.homeLong ==
                                                        double.parse(
                                                            (model.currentPosition.latitude).toStringAsFixed(3)))
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
                                    (snapLog.data == 'clock-out' || snapLog.data == 'break')
                                        ? (difference.inMinutes <= 5)
                                            ? Text(
                                                'ON TIME',
                                                style: TextStyles.bottomTextStyle3,
                                              )
                                            : (difference.inMinutes <= 20)
                                                ? Text(
                                                    'LATE',
                                                    style: TextStyles.alertTextStyle,
                                                  )
                                                : (difference.inMinutes <= 60)
                                                    ? Text(
                                                        'VERY LATE!!!',
                                                        style: TextStyles.alertTextStyle1,
                                                      )
                                                    : (difference.inMinutes <= 210)
                                                        ? Text(
                                                            'OH! HALF DAY?',
                                                            style: TextStyles.alertTextStyle1,
                                                          )
                                                        : Text(
                                                            'OH! HALF DAY?',
                                                            style: TextStyles.alertTextStyle1,
                                                          )
                                        : Text(''),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    (snapLog.data == 'clock-out' || snapLog.data == 'break')
                                        ? ConfirmButton(
                                            firstLog: true,
                                            pressed: model.getLastLog(LogType.clockIn),
                                            type: LogType.clockIn,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _isBtnClicked();
                                              model.markClockIn();
                                              Flushbar(
                                                messageText: Center(
                                                  child: Text(
                                                    "Clocked In Successfully!",
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
                                                    _isBtnClicked();
                                                    model.markClockTimeOut();
                                                    Flushbar(
                                                      messageText: Center(
                                                        child: Text(
                                                          " Taking Break!",
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
                                                    _isBtnClicked();
                                                    model.markClockOut();
                                                    Flushbar(
                                                      messageText: Center(
                                                        child: Text(
                                                          "Clocked Out Successfully!",
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
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: (snapLog.data == 'clock-in')
                                ? Text(
                                    'CLOCK-OUT',
                                    style: TextStyles.buttonTextStyle2,
                                  )
                                : Text(
                                    'CLOCK-IN',
                                    style: TextStyles.buttonTextStyle2,
                                  ),
                          ),
                        );
                      } else {
                        return Text('');
                      }
                    },
                  ),
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
