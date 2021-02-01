import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unplan/model/attendance_detail.dart';
import 'package:unplan/model/attendance_log.dart';
import 'package:unplan/services/shared_pref_service.dart';
import 'package:unplan/utils/utils.dart';

class AttendanceService {
  List<EmployeeDetail> _logs = [];

  List<EmployeeDetail> get logs => _logs;

  StreamController<List<EmployeeDetail>> _logforToday = StreamController<List<EmployeeDetail>>.broadcast();

  Stream<List<EmployeeDetail>> get logForToday => _logforToday.stream;

  Future<Map<String, dynamic>> markLog(String type, String currentAddress, double latitude, double longitude) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int empId = preferences.getInt('id');

    final Map<String, dynamic> logData = {
      'emp_id': empId,
      'date_time': DateTime.now().toString(),
      'time': DateTime.now().toString(),
      'type': type,
      'location': currentAddress,
      'currunt_lat': latitude,
      'currunt_long': longitude,
    };

    var result;
    var token = preferences.getString('token');

    Response response = await post(
      Utils.attendance_url,
      body: json.encode(logData),
      headers: {'Content-Type': 'application/json', 'accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var logData = responseData;
      AttendanceDetail authUser = AttendanceDetail.fromJson(logData);
      await SharedPrefService.storeString('date_time', authUser.employeeAttendanceDetail.dateTime.toString());
      await SharedPrefService.storeString('type', authUser.employeeAttendanceDetail.type);
      result = {'status': true, 'message': 'code ${response.statusCode},${response.body} '};
      getLogToday();
      print(result);
    } else {
      result = {'status': false, 'message': 'code ${response.statusCode},${response.body}'};
      print(result);
    }
    return jsonDecode(response.body);
  }

  Stream<List<EmployeeDetail>> getLogToday() {
    Future.delayed(const Duration(microseconds: 250), () async {
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
        _logs = (json.decode(response.body)['Employee Detail'] as List).map((e) => EmployeeDetail.fromJson(e)).toList();
        _logforToday.sink.add(_logs);
      } else {
        _logforToday.sink.add([]);
      }
    });

    return _logforToday.stream;
  }
}
