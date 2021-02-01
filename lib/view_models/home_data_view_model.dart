import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/model/attendance_log.dart';
import 'package:unplan/services/attendance_service.dart';

class HomeDataViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();

  List<EmployeeDetail> _logs = [];

  List<EmployeeDetail> get logs => _logs;

  initialise() {
    setBusy(true);
    _attendanceService.getLogToday().listen((event) {
      _logs = event;
      setBusy(false);
    });
  }
}
