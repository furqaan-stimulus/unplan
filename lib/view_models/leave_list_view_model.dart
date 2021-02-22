import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';
import 'package:unplan/model/employee_information.dart';
import 'package:unplan/model/leave_list_log.dart';
import 'package:unplan/services/attendance_service.dart';

class LeaveListViewModel extends BaseViewModel {
  final DialogService _dialogService = getIt<DialogService>();
  final NavigationService _navigationService = getIt<NavigationService>();
  final AttendanceService _attendanceService = getIt<AttendanceService>();

  String _name;
  List<LeaveListLog> _leaveList = [];
  List<LeaveListLog> _yearlyLeaveList = [];
  List<EmployeeInformation> _getEmpInfo = [];

  String get name => _name;

  List<LeaveListLog> get leaveList => _leaveList;

  List<LeaveListLog> get yearlyLeaveList => _yearlyLeaveList;

  List<EmployeeInformation> get getEmpInfo => _getEmpInfo;

  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _name = preferences.getString('name');
    notifyListeners();
    return _name;
  }

  Future navigateTOHomeView() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }

  Future initialise() async {
    _attendanceService.getLeavesList().listen((event) {
      _leaveList = event;
    });
  }

  Future getYearlyLeave() async {
    _attendanceService.getYearlyLeaveLog().listen((event) {
      _yearlyLeaveList = event;
    });
  }

  Future getEmpInfoList() async {
    _attendanceService.getEmployeeInfo().listen((event) {
      _getEmpInfo = event;
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
