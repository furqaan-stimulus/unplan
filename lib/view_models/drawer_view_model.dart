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
    var token = preferences.setString("token", null);
    preferences.clear();
    var response;
    response = await _dialogService.showDialog(
      title: 'Are You Sure',
      description: 'Do You want to Logout?',
      buttonTitle: 'Logout ',
      cancelTitle: 'Cancel',
    );
    _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }
}
