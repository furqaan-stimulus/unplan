import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';

class LoginViewModel extends BaseViewModel {
  NavigationService _navigationService = getIt<NavigationService>();

  Future navigateToHomeView() async {
    _navigationService.navigateTo(Routes.homeView);
  }
}
