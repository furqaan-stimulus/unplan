import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';
import 'package:unplan/model/personal_information.dart';
import 'package:unplan/services/attendance_service.dart';

class PersonalInfoViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();
  final NavigationService _navigationService = getIt<NavigationService>();

  String _name;

  String get name => _name;

  List<PersonalInformation> _userDataList = [];

  List<PersonalInformation> get userDataList => _userDataList;

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

  Future initialise() async {
    _attendanceService.getUserProfile().listen(
      (event) {
        _userDataList = event;
      },
    );
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
