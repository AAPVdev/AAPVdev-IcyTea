import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  Future<LatLng?> getCurrentLocation() async {
    var location = Location();
    PermissionStatus status = await location.requestPermission();
    if (status == PermissionStatus.granted) {
      LocationData currentLocation = await location.getLocation();
      return LatLng(currentLocation.latitude!, currentLocation.longitude!);
    } else {
      return null;
    }
  }
}
