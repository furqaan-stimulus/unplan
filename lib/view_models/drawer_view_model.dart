import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';

class DrawerViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  final DialogService _dialogService = getIt<DialogService>();

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

  Future navigateToPersonalInfoView() async {
    await _navigationService.navigateTo(Routes.personalInfoView);
  }

  Future navigateToEmployeeInfoView() async {
    await _navigationService.navigateTo(Routes.employeeInfoView);
  }

  Future navigateToLeavesView() async {
    await _navigationService.navigateTo(Routes.leavesView);
  }

  Future navigateToLeavesListView() async {
    await _navigationService.navigateTo(Routes.leaveListView);
  }

  Future logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    var response;
    response = await _dialogService.showDialog(
      title: 'Are You Sure',
      description: 'Do You want to Logout?',
      buttonTitle: 'Logout ',
      cancelTitle: 'Cancel',
    );
    await _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }
  
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
