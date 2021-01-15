import 'package:stacked/stacked.dart';
import 'package:unplan/app/locator.dart';
import 'package:unplan/services/location_service.dart';

class HomeLogViewModel extends BaseViewModel {
  LocationService _locationService = getIt<LocationService>();
  String _latLong;
  String _getNameLocation;

  String get latLong => _latLong;

  String get getNameLocation => _getNameLocation;

  Future getLocation() async {
    var position = await _locationService.getCurrentLocation();
    _latLong = position.toString();
    notifyListeners();
  }

  Future setNameLocation(lat, long) async {
    var position = await _locationService.getAddressFromLatLng(
        double.parse(lat), double.parse(long));
    _getNameLocation = position.toString();
    notifyListeners();
  }
}
