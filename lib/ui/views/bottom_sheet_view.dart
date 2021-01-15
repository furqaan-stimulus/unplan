import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/bottom_sheet_view_model.dart';

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
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => BottomSheetViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Container(
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
                'assets/svg/home.svg',
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
                      'Working From Home',
                      style: TextStyles.bottomTextStyle,
                    )
                  : Text(
                      'Home',
                      style: TextStyles.bottomTextStyle,
                    ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Naranpura Ahmedabad',
                style: TextStyles.bottomTextStyle2,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'ON TIME',
                style: TextStyles.bottomTextStyle3,
              ),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 150,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 150,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
