import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
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
    return _name;
  }

  final AttendanceService _attendanceService = getIt<AttendanceService>();
  final DialogService _dialogService = getIt<DialogService>();

  List<AttendanceLog> _logs = [];

  List<AttendanceLog> get logs => _logs;
  String _logType;

  String get logType => _logType;

  Future initialise() async {
    _attendanceService.getLogToday().listen((event) {
      _logs = event;
    });
  }

  Future getLogType() async {
    setBusy(true);
    _attendanceService.getLogToday().listen((event) {
      _logType = event.last.type;
    });
    return _logType;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return Future.error('Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
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
  }

  Future initializeNotification() async {
    DateTime notificationDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 25, 00);
    DateTime notificationDate1 =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 21, 30, 00);
    DateTime notificationDate2 =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 30, 00);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails('unplan_channel_id', 'Unplan', 'Unplan',
        priority: Priority.high, importance: Importance.max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

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
            tz.TZDateTime.from(notificationDate, tz.local).add(const Duration(seconds: 5)),
            platformChannelSpecifics,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);

        await MyApp.notifications.zonedSchedule(
            1,
            'Alert!!',
            "Did you forget to logout?",
            tz.TZDateTime.from(notificationDate1, tz.local).add(const Duration(seconds: 5)),
            platformChannelSpecifics,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);

        await MyApp.notifications.zonedSchedule(
            2,
            'Alert!!',
            "You will be clocked-out in 29 minutes.",
            tz.TZDateTime.from(notificationDate2, tz.local).add(const Duration(seconds: 5)),
            platformChannelSpecifics,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
      }
    }
  }

  Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        return true;
      } else {
        _dialogService.showDialog(
          title: 'No internet Connection',
          description: 'Please Check Your Internet Connection',
          cancelTitle: 'Cancel',
        );
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        return true;
      } else {
        _dialogService.showDialog(
          title: 'No internet Connection',
          description: 'Please Check Your Internet Connection',
          cancelTitle: 'Cancel',
        );
        return false;
      }
    } else {
      _dialogService.showDialog(
        title: 'No internet Connection',
        description: 'Please Check Your Internet Connection',
        cancelTitle: 'Cancel',
      );
      return false;
    }
  }
}
