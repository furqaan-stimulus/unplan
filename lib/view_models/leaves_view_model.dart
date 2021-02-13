import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';
import 'package:unplan/model/employee_information.dart';
import 'package:unplan/services/attendance_service.dart';

class LeavesViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();
  final NavigationService _navigationService = getIt<NavigationService>();

  String _name;

  String get name => _name;

  List<EmployeeInformation> _getEmpInfo = [];

  List<EmployeeInformation> get getEmpInfo => _getEmpInfo;

  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setBusy(true);
    _name = preferences.getString('name');
    notifyListeners();
    setBusy(false);
    return _name;
  }

  Future navigateTOHomeView() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }

  Future navigateTOLeaveListView() async {
    await _navigationService.navigateTo(Routes.leaveListView);
  }

  initialise() {
    setBusy(true);
    _attendanceService.getEmployeeInfo().listen((event) {
      _getEmpInfo = event;
      setBusy(false);
    });
  }
}
