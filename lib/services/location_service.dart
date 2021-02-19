import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Position _currentPosition;
  String _currentAddress;

  double _officeLat = double.parse((23.041747).toStringAsFixed(2));
  double _officeLong = double.parse((72.5518427).toStringAsFixed(2));

  double _homeLat = double.parse((23.029326).toStringAsFixed(2));
  double _homeLong = double.parse((72.5963621).toStringAsFixed(2));

  double get officeLat => _officeLat;

  double get officeLong => _officeLong;

  double get homeLat => _homeLat;

  double get homeLong => _homeLong;

  Position get currentPosition => _currentPosition;

  String get currentAddress => _currentAddress;

  Future getCurrentLocation() async {
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
      intervalDuration: Duration(minutes: 10),
    ).listen((Position position) {
      _currentPosition = position;
      getAddressFromLatLng();
    });
  }

  Future getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          double.parse((_officeLat).toStringAsFixed(2)),
          double.parse((_officeLong).toStringAsFixed(2)));
      Placemark place = p[0];
      _currentAddress = "${place.subLocality}, ${place.locality}";
    } catch (e) {
      print(e);
    }
  }
}
