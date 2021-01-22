import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';

class ClockInButton extends StatefulWidget {
  final LogType type;
  final bool pressed;
  final bool firstLog;
  final Function() onPressed;

  const ClockInButton({Key key, this.type, this.pressed, this.firstLog, this.onPressed}) : super(key: key);

  @override
  _ClockInButtonState createState() => _ClockInButtonState();
}

class _ClockInButtonState extends State<ClockInButton> {
  bool isClicked = true;

  void _isBtnClicked() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: isClicked ? ViewColor.button_grey_color : ViewColor.button_green_color,
        onPressed: () {
          // model.getCurrentLocation();
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
                  Text(
                    'address',
                    style: TextStyles.bottomTextStyle2,
                  ),
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
                      ? Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "CONFIRM",
                                style: TextStyles.bottomButtonText,
                              ),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(16),
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
                              color: ViewColor.background_purple_color,
                            ),
                          ),
                        )
                      : Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: 160,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "BREAK",
                                    style: TextStyles.bottomButtonText,
                                  ),
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(16),
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
                                  color: ViewColor.background_purple_color,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: 160,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "SIGN OFF",
                                    style: TextStyles.buttonTextStyle1,
                                  ),
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(16),
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
                                  color: ViewColor.button_green_color,
                                ),
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
          child: isClicked
              ? Text(
                  'CLOCK-IN',
                  style: TextStyles.buttonTextStyle2,
                )
              : Text(
                  'CLOCK-OUT',
                  style: TextStyles.buttonTextStyle2,
                ),
        ),
      ),
    );
  }
}
