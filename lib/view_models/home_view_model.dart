import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/model/attendance_log.dart';
import 'package:unplan/services/attendance_service.dart';

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

  final AttendanceService _attendanceService = getIt<AttendanceService>();

  List<EmployeeDetail> _logs = [];

  List<EmployeeDetail> get logs => _logs;

  initialise() {
    setBusy(true);
    _attendanceService.getLogToday().listen((event) {
      _logs = event;
      setBusy(false);
    });
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
