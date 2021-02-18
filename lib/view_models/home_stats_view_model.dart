import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
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

  Future getLogList() async {
    setBusy(true);
    _attendanceService.getTodayLogList().listen((event) {
      _logList = event;
      setBusy(false);
    });
  }

  final DialogService _dialogService = getIt<DialogService>();

  Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
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
