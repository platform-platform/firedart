import 'package:firedart/src/generated/google/type/latlng.pb.dart';

class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint(this.latitude, this.longitude);

  GeoPoint.fromLatLng(LatLng value) : this(value.latitude, value.longitude);

  @override
  bool operator ==(other) =>
      runtimeType == other.runtimeType &&
      latitude == other.latitude &&
      longitude == other.longitude;

  @override
  String toString() => 'lat: $latitude, lon: $longitude';

  LatLng toLatLng() => LatLng()
    ..latitude = latitude
    ..longitude = longitude;
}
