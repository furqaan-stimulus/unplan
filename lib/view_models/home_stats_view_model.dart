import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/model/employee_information.dart';
import 'package:unplan/model/leave_list_log.dart';
import 'package:unplan/model/present_by_month.dart';
import 'package:unplan/model/today_log.dart';
import 'package:unplan/services/attendance_service.dart';

class HomeStatsViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();
  final DialogService _dialogService = getIt<DialogService>();

  List<EmployeeInformation> _getEmpInfo = [];

  List<EmployeeInformation> get getEmpInfo => _getEmpInfo;

  List<LeaveListLog> _leaveList = [];

  List<LeaveListLog> get leaveList => _leaveList;

  List<LeaveListLog> _leaveMonthList = [];

  List<LeaveListLog> get leaveMonthList => _leaveMonthList;

  List<TodayLog> _logList = [];

  List<TodayLog> get logList => _logList;

  List<PresentByMonth> _logPresentList = [];

  List<PresentByMonth> get logPresentList => _logPresentList;

  Future initialise() async {
    _attendanceService.getEmployeeInfo().listen((event) {
      _getEmpInfo = event;
    });
  }

  Future getLeaveCount() async {
    _attendanceService.getLeavesList().listen((event) {
      _leaveList = event;
    });
  }

  Future getLeaveMonthCount() async {
    _attendanceService.getMonthlyLeaveLog().listen((event) {
      _leaveMonthList = event;
    });
  }

  Future getPresentCount() async {
    _attendanceService.getMonthlyPresentLog().listen((event) {
      _logPresentList = event;
    });
  }

  Future getLogList() async {
    _attendanceService.getTodayLogList().listen((event) {
      _logList = event;
    });
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
