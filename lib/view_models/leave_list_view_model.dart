import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';
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

  initialise() {
    setBusy(true);
    _attendanceService.getLeavesList().listen((event) {
      _leaveList = event;
      setBusy(false);
    });
  }
}
