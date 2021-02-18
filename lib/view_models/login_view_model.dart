import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';
import 'package:unplan/model/login.dart';
import 'package:unplan/services/shared_pref_service.dart';
import 'package:unplan/utils/utils.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  final SnackbarService _snackBarService = getIt<SnackbarService>();
  final DialogService _dialogService = getIt<DialogService>();
  var result;

  Future<Map<String, dynamic>> postLogin(String email, String password) async {
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
    };

    Response response = await post(
      Utils.login_url,
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json', 'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      setBusy(true);
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData;
      Login authUser = Login.fromJson(userData);

      await SharedPrefService.storeString('token', authUser.token);
      await SharedPrefService.storeString('email', authUser.userDetail.email);
      await SharedPrefService.storeString('name', authUser.userDetail.name);
      await SharedPrefService.storeInt('id', authUser.userDetail.id);

      result = {'status': true, 'message': 'code ${response.statusCode} '};
      _snackBarService.showSnackbar(message: 'login Successful');
      _navigationService.pushNamedAndRemoveUntil(
        Routes.homeView,
      );
      setBusy(false);
    } else {
      result = {'status': false, 'message': 'code ${response.statusCode} '};
      _snackBarService.showSnackbar(message: 'login failed!! Enter correct credentials');
    }
    return json.decode(response.body);
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
