import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/model/attendance_log.dart';
import 'package:unplan/services/attendance_service.dart';
import 'package:unplan/model/address_detail.dart';
import 'package:unplan/utils/utils.dart';

class AttendanceLogControlViewModel extends BaseViewModel {
  Position _currentPosition;
  String _currentAddress;

  // double _officeLat = double.parse((23.041747).toStringAsFixed(2));
  // double _officeLong = double.parse((72.5518427).toStringAsFixed(2));
  //
  // double _homeLat = double.parse((23.029326).toStringAsFixed(2));
  // double _homeLong = double.parse((72.5963621).toStringAsFixed(2));
  //
  // double get officeLat => _officeLat;
  //
  // double get officeLong => _officeLong;
  //
  // double get homeLat => _homeLat;
  //
  // double get homeLong => _homeLong;

  Position get currentPosition => _currentPosition;

  String get currentAddress => _currentAddress;

  String _logType;

  String get logType => _logType;

  List<AttendanceLog> _logs = [];

  List<AttendanceLog> get logs => _logs;

  List<AddressDetail> _addressDetail = [];

  List<AddressDetail> get addressDetail => _addressDetail;

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
      desiredAccuracy: LocationAccuracy.best,
      distanceFilter: 10,
    ).listen((Position position) {
      _currentPosition = position;
      print('$_currentPosition');
      getAddressFromLatLng();
    });
    setBusy(false);
  }

  Future getAddressFromLatLng() async {
    setBusy(true);
    try {
      List<Placemark> p = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      _currentAddress = "${place.subLocality}, ${place.locality}";
      print('$_currentAddress');
      notifyListeners();
    } catch (e) {
      print("address error $e");
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
        Utils.CLOCKIN, _currentAddress, _currentPosition.latitude, _currentPosition.longitude);
    notifyListeners();
  }

  markClockOut() async {
    await _attendanceService.markLog(
        Utils.CLOCKOUT, _currentAddress, _currentPosition.latitude, _currentPosition.longitude);
    notifyListeners();
  }

  markClockTimeOut() async {
    await _attendanceService.markLog(
        Utils.TIMEOUT, _currentAddress, _currentPosition.latitude, _currentPosition.longitude);
    notifyListeners();
  }
}
