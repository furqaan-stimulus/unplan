import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/model/employee_information.dart';
import 'package:unplan/model/leave_list_log.dart';
import 'package:unplan/model/today_log.dart';
import 'package:unplan/services/attendance_service.dart';

class HomeStatsViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();
  List<EmployeeInformation> _getEmpInfo = [];

  List<EmployeeInformation> get getEmpInfo => _getEmpInfo;

  List<LeaveListLog> _leaveList = [];

  List<LeaveListLog> get leaveList => _leaveList;

  List<TodayLog> _logList = [];

  List<TodayLog> get logList => _logList;

  initialise() {
    setBusy(true);
    _attendanceService.getEmployeeInfo().listen((event) {
      _getEmpInfo = event;
      setBusy(false);
    });
  }

  getLeaveCount() {
    setBusy(true);
    _attendanceService.getLeavesList().listen((event) {
      _leaveList = event;
      setBusy(false);
    });
  }

  getLogList() {
    setBusy(true);
    _attendanceService.getTodayLogList().listen((event) {
      _logList = event;
      setBusy(false);
    });
  }
}
