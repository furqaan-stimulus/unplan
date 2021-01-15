import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/ui/views/home_log_view.dart';
import 'package:unplan/ui/views/home_stats_view.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/view_models/home_view_model.dart';
import 'package:unplan/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // tzd.initializeTimeZones();
    // _initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var format = DateFormat('EEEE, MMM d yyyy').format(now);

    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        body: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            Column(
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
                              TextSpan(
                                  text: 'hi ', style: TextStyles.homeTitle),
                              TextSpan(
                                  text: 'furqaan,',
                                  style: TextStyles.homeTitle),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          format,
                          style: TextStyles.homeSubTitle,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3.6,
                  width: double.infinity,
                  child: HomeLogView(),
                ),
                Container(height: 300, child: HomeStatsView()),
              ],
            ),
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
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await MyApp.notifications.zonedSchedule(
        0,
        'sign off',
        "Did you finish your day?",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
