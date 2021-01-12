import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/services/shared_pref_service.dart';

@module
abstract class ThirdPartyServiceModule {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  SharedPrefService get sharedPrefService;
}