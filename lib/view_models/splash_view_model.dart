import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';

class SplashViewModel extends BaseViewModel {
  NavigationService _navigationService = getIt<NavigationService>();

  Future navigateToLoginView() async {
    _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }

  Future navigateToHomeView() async {
    _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }
}
