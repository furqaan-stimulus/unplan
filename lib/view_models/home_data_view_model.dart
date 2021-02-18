import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
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

  Future initialise() async{
    _attendanceService.getLogToday().listen((event) {
      _logs = event;
    });
  }

  Future getLogList() async{
    _attendanceService.getTodayLogList().listen((event) {
      _logList = event;
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
