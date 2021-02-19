// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/attendance_service.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';
import '../services/shared_pref_service.dart';
import '../services/third_party_service_module.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServiceModule = _$ThirdPartyServiceModule();
  gh.lazySingleton<AttendanceService>(
      () => thirdPartyServiceModule.attendanceService);
  gh.lazySingleton<AuthService>(() => thirdPartyServiceModule.authService);
  gh.lazySingleton<DialogService>(() => thirdPartyServiceModule.dialogService);
  gh.lazySingleton<LocationService>(
      () => thirdPartyServiceModule.locationService);
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServiceModule.navigationService);
  gh.lazySingleton<SharedPrefService>(
      () => thirdPartyServiceModule.sharedPrefService);
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServiceModule.snackBarService);
  return get;
}

class _$ThirdPartyServiceModule extends ThirdPartyServiceModule {
  @override
  AttendanceService get attendanceService => AttendanceService();
  @override
  AuthService get authService => AuthService();
  @override
  DialogService get dialogService => DialogService();
  @override
  LocationService get locationService => LocationService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SharedPrefService get sharedPrefService => SharedPrefService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
