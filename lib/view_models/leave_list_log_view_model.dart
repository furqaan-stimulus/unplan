import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/model/leave_list_log.dart';
import 'package:unplan/services/attendance_service.dart';

class LeaveListLogViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();
  List<LeaveListLog> _leaveList = [];

  List<LeaveListLog> get leaveList => _leaveList;

  Future initialise() async{
    _attendanceService.getLeavesList().listen((event) {
      _leaveList = event;
    });
  }
}
