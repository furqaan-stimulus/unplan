import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';
import 'package:unplan/model/employee_information.dart';
import 'package:unplan/model/leave_list_log.dart';
import 'package:unplan/services/attendance_service.dart';

class LeaveListViewModel extends BaseViewModel {
  String _name;

  String get name => _name;

  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setBusy(true);
    _name = preferences.getString('name');
    notifyListeners();
    setBusy(false);
    return _name;
  }

  final NavigationService _navigationService = getIt<NavigationService>();

  Future navigateTOHomeView() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }

  final AttendanceService _attendanceService = getIt<AttendanceService>();
  List<LeaveListLog> _leaveList = [];

  List<LeaveListLog> get leaveList => _leaveList;

  List<EmployeeInformation> _getEmpInfo = [];

  List<EmployeeInformation> get getEmpInfo => _getEmpInfo;

  initialise() {
    setBusy(true);
    _attendanceService.getLeavesList().listen((event) {
      _leaveList = event;
      setBusy(false);
    });
  }

  getEmpInfoList(){
    setBusy(true);
    _attendanceService.getEmployeeInfo().listen((event) {
      _getEmpInfo = event;
      setBusy(false);
    });
  }
}
