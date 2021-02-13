import 'dart:async';
import 'dart:convert';
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
  var result;

  Future<Map<String, dynamic>> postLogin(String email, String password) async {
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
    };

    Response response = await post(
      Utils.login_url,
      body: json.encode(loginData),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
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
      _snackBarService.showSnackbar(
          message: 'login failed!! Enter correct credentials');
    }
    return json.decode(response.body);
  }
}
