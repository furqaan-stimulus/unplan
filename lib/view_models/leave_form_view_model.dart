import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/model/employee_information.dart';
import 'package:unplan/services/attendance_service.dart';

class LeaveFormViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();

  List<EmployeeInformation> _getEmpInfo = [];

  List<EmployeeInformation> get getEmpInfo => _getEmpInfo;

  postLeave(String type, String fromDate, String toDate, String reasonOfLeave, int totalDays, int paidLeave,
      int sickLeave, int unpaidLeave, int remainPaid, int remainSick) async {
    await _attendanceService.postLeave(
        type, fromDate, toDate, reasonOfLeave, totalDays, paidLeave, sickLeave, unpaidLeave);
    await _attendanceService.updateLeavesCount(remainPaid, remainSick);
    notifyListeners();
  }

  Future initialise() async{
    _attendanceService.getEmployeeInfo().listen((event) {
      _getEmpInfo = event;
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
