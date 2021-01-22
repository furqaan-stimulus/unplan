import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/model/attendance_detail.dart';
import 'package:unplan/model/log_model.dart';
import 'package:unplan/services/shared_pref_service.dart';
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

  Future getLogType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _logType = preferences.getString('type');
    notifyListeners();
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

  List<LogModel> _logs = [];

  List<LogModel> get logs => _logs;

  getLastLog(LogType type) {
    if (type == LogType.clockIn) {
      return _logs.length == 0 ? false : _logs.first.type == type;
    } else if (type == LogType.timeout) {
      return _logs.length == 0 ? true : _logs.first.type == type;
    } else {
      return _logs.length == 0 ? true : _logs.first.type == type;
    }
  }

  Future<Map<String, dynamic>> markClockIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int empId = preferences.getInt('id');

    final Map<String, dynamic> clockInData = {
      'emp_id': empId,
      'date_time': DateTime.now().toString(),
      'time': DateTime.now().toString(),
      'type': 'clock-in',
      'location': _currentAddress,
      'currunt_lat': currentPosition.latitude,
      'currunt_long': currentPosition.longitude,
    };

    print('post data $clockInData');

    var token = preferences.getString('token');

    Response response = await post(
      Utils.attendance_url,
      body: json.encode(clockInData),
      headers: {'Content-Type': 'application/json', 'accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    var result;
    if (response.statusCode == 200) {
      setBusy(true);

      final Map<String, dynamic> responseData = json.decode(response.body);

      var logData = responseData;
      AttendanceDetail authUser = AttendanceDetail.fromJson(logData);

      await SharedPrefService.storeString('date_time', authUser.employeeAttendanceDetail.dateTime.toString());
      await SharedPrefService.storeString('type', authUser.employeeAttendanceDetail.type);

      result = {'status': true, 'message': 'code ${response.statusCode},${response.body} '};
      setBusy(false);
    } else {
      result = {'status': false, 'message': 'code ${response.statusCode},${response.body} '};
      print('fail: $result');
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> markClockOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    int empId = preferences.getInt('id');

    final Map<String, dynamic> clockOutData = {
      'emp_id': empId,
      'date_time': DateTime.now().toString(),
      'time': DateTime.now().toString(),
      'type': 'clock-out',
      'location': _currentAddress,
      'currunt_lat': currentPosition.latitude,
      'currunt_long': currentPosition.longitude,
    };
    var token = preferences.getString('token');

    Response response = await post(
      Utils.attendance_url,
      body: json.encode(clockOutData),
      headers: {'Content-Type': 'application/json', 'accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    var url = Utils.attendance_url;
    print(url);
    var result;
    if (response.statusCode == 200) {
      setBusy(true);
      final Map<String, dynamic> responseData = json.decode(response.body);
      var logData = responseData;
      AttendanceDetail authUser = AttendanceDetail.fromJson(logData);

      await SharedPrefService.storeString('date_time', authUser.employeeAttendanceDetail.dateTime.toString());
      await SharedPrefService.storeString('type', authUser.employeeAttendanceDetail.type);

      result = {'status': true, 'message': 'code ${response.statusCode},${response.body} '};
      print('success: $result');
      setBusy(false);
    } else {
      print(response.body);
      result = {'status': false, 'message': 'code ${response.statusCode},${response.body} '};
      print('fail: $result');
    }
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> markClockTimeOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    int empId = preferences.getInt('id');

    final Map<String, dynamic> timeOutData = {
      'emp_id': empId,
      'date_time': DateTime.now().toString(),
      'time': DateTime.now().toString(),
      'type': 'break',
      'location': _currentAddress,
      'currunt_lat': currentPosition.latitude,
      'currunt_long': currentPosition.longitude,
    };
    var token = preferences.getString('token');
    Response response = await post(
      Utils.attendance_url,
      body: json.encode(timeOutData),
      headers: {'Content-Type': 'application/json', 'accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    var url = Utils.attendance_url;
    print(url);
    var result;
    if (response.statusCode == 200) {
      setBusy(true);
      final Map<String, dynamic> responseData = json.decode(response.body);
      var logData = responseData;
      AttendanceDetail authUser = AttendanceDetail.fromJson(logData);

      await SharedPrefService.storeString('date_time', authUser.employeeAttendanceDetail.dateTime.toString());
      await SharedPrefService.storeString('type', authUser.employeeAttendanceDetail.type);

      result = {'status': true, 'message': 'code ${response.statusCode},${response.body} '};
      print('success: $result');
      setBusy(false);
    } else {
      print(response.body);
      result = {'status': false, 'message': 'code ${response.statusCode},${response.body} '};
      print('fail: $result');
    }
    return jsonDecode(response.body);
  }
}
