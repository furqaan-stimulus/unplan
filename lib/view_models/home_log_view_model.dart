import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/model/attendance_log.dart';
import 'package:unplan/model/today_log.dart';
import 'package:unplan/services/attendance_service.dart';
import 'package:unplan/model/address_detail.dart';
import 'package:unplan/utils/date_time_format.dart';
import 'package:unplan/utils/utils.dart';

class HomeLogViewModel extends BaseViewModel {
  Position _currentPosition;
  String _currentAddress;

  double _officeLat = double.parse((23.041747).toStringAsFixed(2));
  double _officeLong = double.parse((72.5518427).toStringAsFixed(2));

  double _homeLat = double.parse((23.029326).toStringAsFixed(2));
  double _homeLong = double.parse((72.5963621).toStringAsFixed(2));

  double get officeLat => _officeLat;

  double get officeLong => _officeLong;

  double get homeLat => _homeLat;

  double get homeLong => _homeLong;

  Position get currentPosition => _currentPosition;

  String get currentAddress => _currentAddress;

  String _logType;

  String get logType => _logType;

  List<AttendanceLog> _logs = [];

  List<AttendanceLog> get logs => _logs;

  List<AddressDetail> _addressDetail = [];

  List<AddressDetail> get addressDetail => _addressDetail;
  List<TodayLog> _logList = [];

  List<TodayLog> get logList => _logList;

  var result;

  final AttendanceService _attendanceService = getIt<AttendanceService>();

  Future getLogType() async {
    setBusy(true);
    _attendanceService.getLogToday().listen((event) {
      if (_logType != null) {
        _logType = event.last.type;
      } else {
        _logs = event;
      }
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
      List<Placemark> p = await placemarkFromCoordinates(double.parse((currentPosition.latitude).toStringAsFixed(2)),
          double.parse((currentPosition.longitude).toStringAsFixed(2)));
      Placemark place = p[0];
      _currentAddress = "${place.subLocality}, ${place.locality}";
      notifyListeners();
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  initialise() {
    setBusy(true);
    _attendanceService.getLogToday().listen((event) {
      _logType = event.last.type;
    });
    setBusy(false);
  }

  fetchLogs() {
    setBusy(true);
    _attendanceService.getLogToday().listen((event) {
      _logs = event;
    });
    setBusy(false);
  }

  fetchAddress() {
    setBusy(true);
    _attendanceService.getUserAddress().listen((event) {
      _addressDetail = event;
      notifyListeners();
    });
    setBusy(false);
  }

  getLastLog(LogType type) {
    if (type == LogType.clockIn) {
      return _logs.length == 0 ? false : _logs.first.type == type;
    } else if (type == LogType.timeout) {
      return _logs.length == 0 ? true : _logs.first.type == type;
    } else {
      return _logs.length == 0 ? true : _logs.first.type == type;
    }
  }

  markClockIn() async {
    await _attendanceService.markLog(
        Utils.CLOCKIN, _currentAddress, currentPosition.latitude, currentPosition.longitude, 0, 0);
  }

  markClockOut() async {
    double totalHour = DateTimeFormat.calculateHoursForSingleDay(_logList);
    print("total: ${totalHour.toInt()}");
    int present = 0;
    // if (totalHour.toInt() >= 4) {
    //   print("if");
    //   await _attendanceService.markLog(Utils.CLOCKOUT, _currentAddress, currentPosition.latitude,
    //       currentPosition.longitude, present++, totalHour.toInt());
    // } else {
    //   print("else");
    //   await _attendanceService.markLog(
    //       Utils.CLOCKOUT, _currentAddress, currentPosition.latitude, currentPosition.longitude, 0, totalHour.toInt());
    // }
    await _attendanceService.markLog(
        Utils.CLOCKOUT, _currentAddress, currentPosition.latitude, currentPosition.longitude, present++, totalHour);
  }

  markClockTimeOut() async {
    await _attendanceService.markLog(
        Utils.TIMEOUT, _currentAddress, currentPosition.latitude, currentPosition.longitude, 0, 0);
  }
}
