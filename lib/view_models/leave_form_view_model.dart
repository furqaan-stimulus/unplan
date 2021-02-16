import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/model/employee_information.dart';
import 'package:unplan/services/attendance_service.dart';

class LeaveFormViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();

  List<EmployeeInformation> _getEmpInfo = [];

  List<EmployeeInformation> get getEmpInfo => _getEmpInfo;

  postLeave(String type, String fromDate, String toDate, String reasonOfLeave,int totalDays) async {
    await _attendanceService.postLeave(type, fromDate, toDate, reasonOfLeave,totalDays);
    notifyListeners();
  }

  initialise() {
    setBusy(true);
    _attendanceService.getEmployeeInfo().listen((event) {
      _getEmpInfo = event;
      setBusy(false);
    });
  }
}