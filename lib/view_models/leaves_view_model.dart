import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';

class LeavesViewModel extends BaseViewModel {
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

  Future navigateTOLeaveListView() async {
    await _navigationService.navigateTo(Routes.leaveListView);
  }
}
