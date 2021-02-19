import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  final DialogService _dialogService = getIt<DialogService>();
  final AuthService _authService = getIt<AuthService>();

  // final SnackbarService _snackBarService = getIt<SnackbarService>();
  var result;

  Future postLogin(
    String email,
    String password,
  ) async {
    // final SharedPreferences preferences = await SharedPreferences.getInstance();
    // var devOs = preferences.getString('deviceOs');
    // var devId = preferences.getString('deviceId');
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // if (Platform.isAndroid) {
    //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //   if (androidInfo.id == null && androidInfo.model == null) {
    //     print('login if');
    //     await _authService.postLogin(email, password);
    //     await _authService.updateDeviceInfo(androidInfo.id, androidInfo.model);
    //   } else if (devOs == androidInfo.model && devId == androidInfo.id) {
    //     print('login elseif');
    //     await _authService.postLogin(email, password);
    //   } else {
    //     print('login else');
    //     _snackBarService.showSnackbar(message: 'You are logging from another device');
    //   }
    // } else {
    //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //   if (iosInfo.identifierForVendor == null && iosInfo.model == null) {
    //     await _authService.postLogin(email, password);
    //     await _authService.updateDeviceInfo(iosInfo.identifierForVendor, iosInfo.model);
    //   } else if (devOs == iosInfo.model && devId == iosInfo.identifierForVendor) {
    //     await _authService.postLogin(email, password);
    //   } else {
    //     _snackBarService.showSnackbar(message: 'You are logging from another device');
    //   }
    // }
    await _authService.postLogin(email, password);
  }

  Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
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
      if (await DataConnectionChecker().hasConnection) {
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
