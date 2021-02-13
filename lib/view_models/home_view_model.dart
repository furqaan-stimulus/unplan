import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/model/attendance_log.dart';
import 'package:unplan/services/attendance_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:unplan/utils/utils.dart';
import '../main.dart';

class HomeViewModel extends BaseViewModel {
  Position _currentPosition;
  String _currentAddress;

  Position get currentPosition => _currentPosition;

  String get currentAddress => _currentAddress;
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

  List<AttendanceLog> _logs = [];

  List<AttendanceLog> get logs => _logs;
  String _logType;

  String get logType => _logType;

  initialise() {
    setBusy(true);
    _attendanceService.getLogToday().listen((event) {
      _logs = event;
      setBusy(false);
    });
  }

  Future getLogType() async {
    setBusy(true);
    _attendanceService.getLogToday().listen((event) {
      _logType = event.last.type;
      notifyListeners();
    });
    return _logType;
  }

  Future getCurrentLocation() async {
    setBusy(true);
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
      intervalDuration: Duration(minutes: 10),
    ).listen((Position position) {
      _currentPosition = position;
      getAddressFromLatLng();
      notifyListeners();
    });
    setBusy(false);
  }

  Future getAddressFromLatLng() async {
    setBusy(true);
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          double.parse((currentPosition.latitude).toStringAsFixed(2)),
          double.parse((currentPosition.longitude).toStringAsFixed(2)));
      Placemark place = p[0];
      _currentAddress = "${place.subLocality}, ${place.locality}";
      notifyListeners();
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  Future initializeNotification() async {
    DateTime notificationDate = DateTime(DateTime.now().year,
        DateTime.now().month, DateTime.now().day, 19, 25, 00);
    DateTime notificationDate1 = DateTime(DateTime.now().year,
        DateTime.now().month, DateTime.now().day, 21, 30, 00);
    DateTime notificationDate2 = DateTime(DateTime.now().year,
        DateTime.now().month, DateTime.now().day, 23, 30, 00);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'unplan_channel_id', 'Unplan', 'Unplan',
        priority: Priority.high, importance: Importance.max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String authToken = preferences.getString('token');
    int empId = preferences.getInt('id');
    Response response;
    if (authToken != null)
      response = await get(
        Utils.attendance_log_url + '$empId',
        headers: {'Authorization': 'Bearer $authToken'},
      );
    if (response != null) {
      _logs = (json.decode(response.body)['Employee Detail'] as List)
          .map((e) => AttendanceLog.fromJson(e))
          .toList();
    }

    if (_logs.length != 0) {
      if (_logs.last.type == Utils.CLOCKIN) {
        await MyApp.notifications.zonedSchedule(
            0,
            'Sign Off!',
            "Did you finish your day?",
            tz.TZDateTime.from(notificationDate, tz.local)
                .add(const Duration(seconds: 5)),
            platformChannelSpecifics,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);

        await MyApp.notifications.zonedSchedule(
            1,
            'Alert!!',
            "Did you forget to logout?",
            tz.TZDateTime.from(notificationDate1, tz.local)
                .add(const Duration(seconds: 5)),
            platformChannelSpecifics,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);

        await MyApp.notifications.zonedSchedule(
            2,
            'Alert!!',
            "You will be clocked-out in 29 minutes.",
            tz.TZDateTime.from(notificationDate2, tz.local)
                .add(const Duration(seconds: 5)),
            platformChannelSpecifics,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
      }
    }
  }
}
