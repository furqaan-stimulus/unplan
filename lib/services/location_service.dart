import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as lt;
import 'package:unplan/model/location_model.dart';

class LocationService {
  LocationModel _currentLocation;
  Position currentPosition;
  String _currentAddress;
  lt.Location location = lt.Location();

  StreamController<LocationModel> _locationController =
      StreamController<LocationModel>.broadcast();

  Stream<LocationModel> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(
              LocationModel(
                latitude: locationData.latitude,
                longitude: locationData.longitude,
              ),
            );
          }
        });
      }
    });
  }

  Future<LocationModel> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = LocationModel(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }

  Future getCurrentLocation() async {
    Future.delayed(Duration(microseconds: 500));
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      currentPosition = position;
      getAddressFromLatLng(currentPosition.latitude, currentPosition.longitude);
    }).catchError((e) {
      print(e);
    });
  }

  Future getAddressFromLatLng(lat, long) async {
    Future.delayed(Duration(seconds: 1));
    try {
      List<Placemark> p = await placemarkFromCoordinates(lat, long);
      print("${currentPosition.latitude} ${currentPosition.longitude}");
      if (p.isNotEmpty) {
        Placemark place = p[0];
        _currentAddress = "${place.subLocality}, ${place.locality},";
      }
    } catch (e) {
      print(e);
    }
  }
}
