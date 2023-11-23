import 'package:tickets/exports/exports.dart';

class LocationService {
  LocationService._();
  static final LocationService instance = LocationService._();
  Future<String> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Services Disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permanently denied');
    }
    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String? location = '${placemark.locality}, ${placemark.postalCode}';
    return location;
  }
}
