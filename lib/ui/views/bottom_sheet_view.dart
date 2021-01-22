import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/bottom_sheet_view_model.dart';
import 'package:unplan/widgets/break_button.dart';
import 'package:unplan/widgets/clock_out_button.dart';
import 'package:unplan/widgets/confirm_button.dart';

class BottomSheetView extends StatefulWidget {
  @override
  _BottomSheetViewState createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  bool isClicked = true;

  void _isBtnClicked() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BottomSheetViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Container(
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
              SvgPicture.asset(
                'assets/svg/office.svg',
                height: 45,
                width: 45,
              ),
              SizedBox(
                height: 20.0,
              ),
              isClicked
                  ? Text(
                      'You are',
                      style: TextStyles.buttonTextStyle2,
                    )
                  : Text(
                      'Logging out from',
                      style: TextStyles.buttonTextStyle2,
                    ),
              SizedBox(
                height: 5.0,
              ),
              isClicked
                  ? Text(
                      'Working From Office',
                      style: TextStyles.bottomTextStyle,
                    )
                  : Text(
                      'Office',
                      style: TextStyles.bottomTextStyle,
                    ),
              SizedBox(
                height: 5.0,
              ),
              (model.currentPosition != null)
                  ? Text(
                      model.currentAddress,
                      style: TextStyles.bottomTextStyle2,
                    )
                  : Text(''),
              SizedBox(
                height: 10.0,
              ),
              isClicked
                  ? Text(
                      'ON TIME',
                      style: TextStyles.bottomTextStyle3,
                    )
                  : Text(''),
              SizedBox(
                height: 20.0,
              ),
              isClicked
                  ? ConfirmButton(
                      firstLog: true,
                      pressed: model.getLastLog(LogType.clockIn),
                      type: LogType.clockIn,
                      onPressed: () {
                        Navigator.of(context).pop();
                        _isBtnClicked();
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
      ),
    );
  }
}
