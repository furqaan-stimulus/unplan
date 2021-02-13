import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/app/router.gr.dart';
import 'package:unplan/model/personal_information.dart';
import 'package:unplan/services/attendance_service.dart';


class PersonalInfoViewModel extends BaseViewModel {
  final AttendanceService _attendanceService = getIt<AttendanceService>();
  final NavigationService _navigationService = getIt<NavigationService>();

  String _name;

  String get name => _name;

  List<PersonalInformation> _userDataList = [];

  List<PersonalInformation> get userDataList => _userDataList;

  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setBusy(true);
    _name = preferences.getString('name');
    notifyListeners();
    setBusy(false);
    return _name;
  }

  Future navigateTOHomeView() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }

  initialise() {
    setBusy(true);
    _attendanceService.getUserProfile().listen((event) {
      _userDataList = event;
      setBusy(false);
    });
  }
}
