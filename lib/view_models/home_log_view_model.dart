import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/model/attendance_log.dart';
import 'package:unplan/model/today_log.dart';
import 'package:unplan/services/attendance_service.dart';
import 'package:unplan/model/address_detail.dart';
import 'package:unplan/services/location_service.dart';
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

  List<AttendanceLog> _totalLogs = [];

  List<AttendanceLog> get totalLogs => _totalLogs;

  List<AddressDetail> _addressDetail = [];

  List<AddressDetail> get addressDetail => _addressDetail;

  List<TodayLog> _logList = [];

  List<TodayLog> get logList => _logList;

  var result;

  final AttendanceService _attendanceService = getIt<AttendanceService>();
  final DialogService _dialogService = getIt<DialogService>();
  final LocationService _locationService = getIt<LocationService>();

  Future getLocation() async {
    var position = await _locationService.getCurrentLocation();
    var latlong = position.toString();
    print("position: $latlong");
  }

  Future getLogType() async {
    _attendanceService.getLogToday().listen((event) {
      if (_logType != null) {
        _logType = event.last.type;
      } else {
        _logs = event;
      }
    });
    return _logType;
  }

  Future getLogList() async {
    _attendanceService.getTodayLogList().listen(
      (event) {
        _logList = event;
      },
    );
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
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
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
      intervalDuration: Duration(minutes: 10),
    ).listen((Position position) {
      _currentPosition = position;
      getAddressFromLatLng();
    });
  }

  Future getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          double.parse((currentPosition.latitude).toStringAsFixed(2)),
          double.parse((currentPosition.longitude).toStringAsFixed(2)));
      Placemark place = p[0];
      _currentAddress = "${place.subLocality}, ${place.locality}";
    } catch (e) {
      print(e);
    }
  }

  Future initialise() async {
    _attendanceService.getLogToday().listen((event) {
      _logType = event.last.type;
    });
  }

  Future fetchLogs() async {
    _attendanceService.getLogToday().listen((event) {
      _logs = event;
    });
  }

  Future fetchTodayLogs() async {
    _attendanceService.getLogToday().listen((event) {
      _totalLogs = event;
    });
  }

  Future fetchAddress() async {
    _attendanceService.getUserAddress().listen((event) {
      _addressDetail = event;
    });
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

  markClockOut(totalHour) async {
    int present = 0;
    var sat = DateTime.saturday;
    var currentDay = DateTime.now().weekday;
    if (currentDay == sat) {
      if (totalHour >= 5.00) {
        await _attendanceService.markLog(Utils.CLOCKOUT, _currentAddress, currentPosition.latitude,
            currentPosition.longitude, present + 1, totalHour);
      } else {
        await _attendanceService.markLog(Utils.CLOCKOUT, _currentAddress, currentPosition.latitude,
            currentPosition.longitude, present, 0);
      }
    } else {
      if (totalHour >= 6.00) {
        await _attendanceService.markLog(Utils.CLOCKOUT, _currentAddress, currentPosition.latitude,
            currentPosition.longitude, present + 1, totalHour);
      } else {
        await _attendanceService.markLog(Utils.CLOCKOUT, _currentAddress, currentPosition.latitude,
            currentPosition.longitude, present, 0);
      }
    }
  }

  markClockTimeOut() async {
    await _attendanceService.markLog(
        Utils.TIMEOUT, _currentAddress, currentPosition.latitude, currentPosition.longitude, 0, 0);
  }

  Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
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
      if (await DataConnectionChecker().hasConnection) {
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
