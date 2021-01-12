import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/ui/views/home_stats_view.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/home_view_model.dart';
import 'package:unplan/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzd;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isClicked = true;

  void _isBtnClicked() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  void initState() {
    super.initState();
    tzd.initializeTimeZones();
    _initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.8,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'hi ', style: TextStyles.homeTitle),
                          TextSpan(text: 'furqaan,', style: TextStyles.homeTitle),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Tuesday, 12 Jan 2021',
                      style: TextStyles.homeSubTitle,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3.4,
              width: double.infinity,
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
                      child: RaisedButton(
                        color: isClicked ? ViewColor.button_grey_color : ViewColor.button_green_color,
                        onPressed: () {
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
                                                    shape:
                                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                                                    shape:
                                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
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
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Last Clock-Out: ', style: TextStyles.homeText),
                          TextSpan(text: '20:22, 06 JAN', style: TextStyles.homeText),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Hours Today: ', style: TextStyles.homeText1),
                          TextSpan(text: '00:00 Hrs', style: TextStyles.homeText1),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Avg. This Month: ', style: TextStyles.homeText1),
                          TextSpan(text: '08:12 Hrs', style: TextStyles.homeText1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 300, child: HomeStatsView()),
          ],
        ),
      ),
    );
  }

  void _initializeNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'attendance_app_channel_id', 'Attendance App', 'Attendance App',
        priority: Priority.high, importance: Importance.max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await MyApp.notifications.zonedSchedule(0, 'sign off', "Did you finish your day?",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
}
