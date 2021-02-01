import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/services/attendance_service.dart';
import 'package:unplan/services/location_service.dart';
import 'package:unplan/services/shared_pref_service.dart';

@module
abstract class ThirdPartyServiceModule {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  SharedPrefService get sharedPrefService;

  @lazySingleton
  SnackbarService get snackBarService;

  @lazySingleton
  AttendanceService get attendanceService;

  @lazySingleton
  LocationService get locationService;
}
