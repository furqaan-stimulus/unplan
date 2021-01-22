import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/main.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeViewModel extends BaseViewModel {
  String _name;

  String get name => _name;

  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setBusy(true);
    _name = preferences.getString('name');
    notifyListeners();
    setBusy(false);
    return _name;
  }

  Future initializeNotification() async {
    DateTime notificationDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 16, 45, 00);
    final date3 = DateTime.now();
    final difference = date3.difference(notificationDate);

    DateTime now = DateTime.now();

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'attendance_app_channel_id', 'Attendance App', 'Attendance App',
        priority: Priority.high, importance: Importance.max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    // if (difference.inMinutes >= 20) {
    //   await MyApp.notifications.zonedSchedule(
    //       0,
    //       'Sign Off!',
    //       "Did you finish your day?",
    //       tz.TZDateTime.from(now, tz.local).add(const Duration(seconds: 5)),
    //       platformChannelSpecifics,
    //       androidAllowWhileIdle: true,
    //       uiLocalNotificationDateInterpretation:
    //           UILocalNotificationDateInterpretation.absoluteTime);
    // }

    // if (difference.inMinutes >= 22) {
    //   await MyApp.notifications.zonedSchedule(
    //       1,
    //       'Alert!!',
    //       "Did you forget to logout?",
    //       tz.TZDateTime.from(now, tz.local).add(const Duration(seconds: 5)),
    //       platformChannelSpecifics,
    //       androidAllowWhileIdle: true,
    //       uiLocalNotificationDateInterpretation:
    //           UILocalNotificationDateInterpretation.absoluteTime);
    // }
    // if (difference.inMinutes > 24) {
    //   await MyApp.notifications.zonedSchedule(
    //       2,
    //       'Alert!!',
    //       "You will be clocked-out in 29 minutes.",
    //       tz.TZDateTime.from(now, tz.local).add(const Duration(seconds: 5)),
    //       platformChannelSpecifics,
    //       androidAllowWhileIdle: true,
    //       uiLocalNotificationDateInterpretation:
    //           UILocalNotificationDateInterpretation.absoluteTime);
    // }
  }
}
