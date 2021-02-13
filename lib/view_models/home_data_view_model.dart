import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/model/attendance_log.dart';
import 'package:unplan/model/today_log.dart';
import 'package:unplan/services/attendance_service.dart';

class HomeDataViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();

  List<AttendanceLog> _logs = [];

  List<AttendanceLog> get logs => _logs;

  List<TodayLog> _logList = [];

  List<TodayLog> get logList => _logList;

  initialise() {
    setBusy(true);
    _attendanceService.getLogToday().listen((event) {
      _logs = event;
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
