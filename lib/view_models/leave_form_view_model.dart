import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/services/attendance_service.dart';

class LeaveFormViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();

  postLeave(String type, String fromDate, String toDate, String reasonOfLeave) async {
    await _attendanceService.postLeave(type, fromDate, toDate, reasonOfLeave);
    notifyListeners();
  }
}
