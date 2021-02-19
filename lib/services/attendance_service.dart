import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unplan/model/address_detail.dart';
import 'package:unplan/model/attendance_log.dart';
import 'package:unplan/model/employee_information.dart';
import 'package:unplan/model/leave_list_log.dart';
import 'package:unplan/model/personal_information.dart';
import 'package:unplan/model/today_log.dart';
import 'package:unplan/services/shared_pref_service.dart';
import 'package:unplan/utils/utils.dart';

class AttendanceService {
  List<AttendanceLog> _logs = [];

  List<AttendanceLog> get logs => _logs;

  List<TodayLog> _logList = [];

  List<TodayLog> get logList => _logList;

  List<TodayLog> _presentList;

  List<TodayLog> get presentList => _presentList;

  List<LeaveListLog> _leaveList = [];

  List<LeaveListLog> get leaveList => _leaveList;

  List<PersonalInformation> _userDataList = [];

  List<PersonalInformation> get userDataList => _userDataList;

  List<AddressDetail> _addDetail = [];

  List<AddressDetail> get addDetail => _addDetail;

  List<EmployeeInformation> _getEmpInfo = [];

  List<EmployeeInformation> get getEmpInfo => _getEmpInfo;

  StreamController<List<EmployeeInformation>> _getEmpInfoStrmCntl =
      StreamController<List<EmployeeInformation>>.broadcast();

  Stream<List<EmployeeInformation>> get getEmpInfoStrm => _getEmpInfoStrmCntl.stream;

  StreamController<List<AttendanceLog>> _logforToday =
      StreamController<List<AttendanceLog>>.broadcast();

  Stream<List<AttendanceLog>> get logForToday => _logforToday.stream;

  StreamController<List<LeaveListLog>> _leaveListCntl =
      StreamController<List<LeaveListLog>>.broadcast();

  Stream<List<LeaveListLog>> get leaveListStream => _leaveListCntl.stream;

  StreamController<List<TodayLog>> _logListToday = StreamController<List<TodayLog>>.broadcast();

  Stream<List<TodayLog>> get logListToday => _logListToday.stream;

  StreamController<List<TodayLog>> _logPresentMonth = StreamController<List<TodayLog>>.broadcast();

  Stream<List<TodayLog>> get logPresentMonth => _logPresentMonth.stream;

  StreamController<List<AddressDetail>> _addressStreamControl =
      StreamController<List<AddressDetail>>.broadcast();

  Stream<List<AddressDetail>> get addressStreamControl => _addressStreamControl.stream;

  StreamController<List<PersonalInformation>> _userDataStrCntl =
      StreamController<List<PersonalInformation>>.broadcast();

  Stream<List<PersonalInformation>> get userDataStream => _userDataStrCntl.stream;

  Future<Map<String, dynamic>> markLog(String type, String currentAddress, double latitude,
      double longitude, int present, double totalHours) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int empId = preferences.getInt('id');
    DateTime now = DateTime.now();
    final Map<String, dynamic> logData = {
      'emp_id': empId,
      'date_time': DateTime.now().toString(),
      'time': DateTime.now().toString(),
      'date': DateTime(now.year, now.month, now.day).toString(),
      'type': type,
      'location': currentAddress,
      'currunt_lat': latitude,
      'currunt_long': longitude,
      'present': present,
      'total_hour': totalHours,
      'avg_hour': 0,
    };

    var result;
    var token = preferences.getString('token');

    Response response = await post(
      Utils.attendance_url,
      body: json.encode(logData),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var logData = responseData;
      AttendanceLog authUser = AttendanceLog.fromJson(logData);
      await SharedPrefService.storeString('date_time', authUser.dateTime.toString());
      await SharedPrefService.storeString('type', authUser.type);
      result = {'status': true, 'message': 'code ${response.statusCode},${response.body} '};
      print(result);
    } else {
      result = {'status': false, 'message': 'code ${response.statusCode},${response.body}'};
      print(result);
    }
    return jsonDecode(response.body);
  }

  Stream<List<AttendanceLog>> getLogToday() {
    Future.delayed(
      const Duration(microseconds: 250),
      () async {
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
          _logforToday.sink.add(_logs);
        } else {
          _logforToday.sink.add([]);
        }
      },
    );
    return _logforToday.stream;
  }

  Stream<List<AddressDetail>> getUserAddress() {
    Future.delayed(const Duration(microseconds: 250), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String authToken = preferences.getString('token');
      int empId = preferences.getInt('id');
      Response response;
      if (authToken != null) {
        response = await get(
          Utils.address_info_url + "$empId",
          headers: {'Authorization': 'Bearer $authToken'},
        );
        if (response != null) {
          _addDetail = (json.decode(response.body)['Employee Detail'] as List)
              .map((e) => AddressDetail.fromJson(e))
              .toList();
          _addressStreamControl.sink.add(_addDetail);
        } else {
          _addressStreamControl.sink.add([]);
        }
      }
    });
    return _addressStreamControl.stream;
  }

  Stream<List<PersonalInformation>> getUserProfile() {
    Future.delayed(const Duration(microseconds: 250), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String authToken = preferences.getString('token');
      int empId = preferences.getInt('id');
      Response response;
      if (authToken != null)
        response = await get(
          Utils.personal_info_url + '$empId',
          headers: {'Authorization': 'Bearer $authToken'},
        );
      if (response != null) {
        _userDataList = (json.decode(response.body)['Personal Info'] as List)
            .map((e) => PersonalInformation.fromJson(e))
            .toList();
        _userDataStrCntl.sink.add(_userDataList);
      } else {
        _userDataStrCntl.sink.add([]);
      }
    });
    return _userDataStrCntl.stream;
  }

  Stream<List<TodayLog>> getTodayLogList() {
    Future.delayed(
      const Duration(microseconds: 250),
      () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String authToken = preferences.getString('token');
        int empId = preferences.getInt('id');
        Response response;
        DateTime now = DateTime.now();

        var queryParameters = {
          'date': DateTime(now.year, now.month, now.day).toString(),
        };
        var uri = Uri.https('dev.stimulusco.com', '/api/attendenceByDate/$empId', queryParameters);
        if (authToken != null)
          response = await get(
            uri,
            headers: {'Authorization': 'Bearer $authToken'},
          );
        if (response != null) {
          _logList = (json.decode(response.body)['Attendence Data'] as List)
              .map((e) => TodayLog.fromJson(e))
              .toList();
          _logListToday.sink.add(_logList);
        } else {
          _logListToday.sink.add([]);
        }
      },
    );
    return _logListToday.stream;
  }

  Future<Map<String, dynamic>> postLeave(
    String type,
    String fromDate,
    String toDate,
    String reasonOfLeave,
    int totalDays,
    int paidLeave,
    int sickLeave,
    int unpaidLeave,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int empId = preferences.getInt('id');
    var token = preferences.getString('token');
    var result;
    final Map<String, dynamic> logData = {
      'apply_date': DateTime.now().toString(),
      'from': fromDate,
      'to': toDate,
      'unpaid_leave': unpaidLeave,
      'paid_leave': paidLeave,
      'sick_leave': sickLeave,
      'leave_type': type,
      'reason_of_leave': reasonOfLeave,
      'status': 'notapproved',
      'total_days': totalDays,
    };
    Response response = await post(
      Utils.post_leave_url + "$empId",
      body: json.encode(logData),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      result = {'status': true, 'message': 'code ${response.statusCode},${response.body}'};
      print("success $result");
    } else {
      result = {'status': true, 'message': 'code ${response.statusCode},${response.body}'};
      print("failed $result");
    }
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> updateLeavesCount(int remainPaid, int remainSick) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int empId = preferences.getInt('id');
    var slug = preferences.getString('slug');
    var token = preferences.getString('token');
    var result;
    final Map<String, dynamic> leaveData = {
      'unsc_leave': remainPaid,
      'sick_leave': remainSick,
    };

    Response response = await post(
      Utils.update_employee_info_url + "$slug" + Utils.PS + "$empId",
      body: json.encode(leaveData),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      result = {'status': true, 'message': 'code ${response.statusCode},${response.body} '};
      print(result);
    } else {
      result = {'status': true, 'message': 'code ${response.statusCode}'};
      print(result);
    }
    return jsonDecode(response.body);
  }

  Stream<List<LeaveListLog>> getLeavesList() {
    Future.delayed(
      const Duration(microseconds: 250),
      () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String authToken = preferences.getString('token');
        int empId = preferences.getInt('id');
        Response response;
        if (authToken != null)
          response = await get(
            Utils.get_leave_url + '$empId',
            headers: {'Authorization': 'Bearer $authToken'},
          );
        if (response != null) {
          _leaveList = (json.decode(response.body)['Employee Leave Info'] as List)
              .map((e) => LeaveListLog.fromJson(e))
              .toList();
          _leaveListCntl.sink.add(_leaveList);
        } else {
          _leaveListCntl.sink.add([]);
        }
      },
    );
    return _leaveListCntl.stream;
  }

  Stream<List<EmployeeInformation>> getEmployeeInfo() {
    Future.delayed(
      const Duration(microseconds: 250),
      () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String authToken = preferences.getString('token');
        int empId = preferences.getInt('id');
        Response response;
        if (authToken != null)
          response = await get(
            Utils.get_employee_info_url + '$empId',
            headers: {'Authorization': 'Bearer $authToken'},
          );
        if (response != null) {
          _getEmpInfo = (json.decode(response.body)['Employee Leave Info'] as List)
              .map((e) => EmployeeInformation.fromJson(e))
              .toList();
          preferences.setString("slug", _getEmpInfo.first.slug);
          _getEmpInfoStrmCntl.sink.add(_getEmpInfo);
        } else {
          _getEmpInfoStrmCntl.sink.add([]);
        }
      },
    );
    return _getEmpInfoStrmCntl.stream;
  }

  Stream<List<TodayLog>> getMonthlyPresentLog() {
    Future.delayed(
      const Duration(microseconds: 250),
      () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String authToken = preferences.getString('token');
        int empId = preferences.getInt('id');
        Response response;
        DateTime now = DateTime.now();

        var queryParameters = {
          'date': DateTime(now.year, now.month, 15).toString(),
        };

        var uri = Uri.https('dev.stimulusco.com', '/api/attendenceByDate/$empId', queryParameters);
        if (authToken != null)
          response = await get(
            uri,
            headers: {'Authorization': 'Bearer $authToken'},
          );
        if (response != null) {
          _presentList = (json.decode(response.body)['Attendence Data'] as List)
              .map((e) => TodayLog.fromJson(e))
              .toList();
          _logPresentMonth.sink.add(_presentList);
        } else {
          _logPresentMonth.sink.add([]);
        }
      },
    );
    return _logPresentMonth.stream;
  }

  Stream<List<TodayLog>> getYearlyLeaveLog() {
    Future.delayed(
      const Duration(microseconds: 250),
      () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String authToken = preferences.getString('token');
        int empId = preferences.getInt('id');
        Response response;
        DateTime now = DateTime.now();

        var queryParameters = {
          'date': DateTime(now.year, now.month, 15).toString(),
        };

        var uri = Uri.https('dev.stimulusco.com', '/api/attendenceByDate/$empId', queryParameters);
        if (authToken != null)
          response = await get(
            uri,
            headers: {'Authorization': 'Bearer $authToken'},
          );
        if (response != null) {
          _presentList = (json.decode(response.body)['Attendence Data'] as List)
              .map((e) => TodayLog.fromJson(e))
              .toList();
          _logPresentMonth.sink.add(_presentList);
        } else {
          _logPresentMonth.sink.add([]);
        }
      },
    );
    return _logPresentMonth.stream;
  }

  Stream<List<TodayLog>> getMonthlyLeaveLog() {
    Future.delayed(
      const Duration(microseconds: 250),
      () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String authToken = preferences.getString('token');
        int empId = preferences.getInt('id');
        Response response;
        DateTime now = DateTime.now();

        var queryParameters = {
          'date': DateTime(now.year, now.month, 15).toString(),
        };

        var uri = Uri.https('dev.stimulusco.com', '/api/attendenceByDate/$empId', queryParameters);
        if (authToken != null)
          response = await get(
            uri,
            headers: {'Authorization': 'Bearer $authToken'},
          );
        if (response != null) {
          _presentList = (json.decode(response.body)['Attendence Data'] as List)
              .map((e) => TodayLog.fromJson(e))
              .toList();
          _logPresentMonth.sink.add(_presentList);
        } else {
          _logPresentMonth.sink.add([]);
        }
      },
    );
    return _logPresentMonth.stream;
  }
}
