import 'package:firedart/firedart.dart';
import 'package:firedart/src/generated/google/type/latlng.pb.dart';
import 'package:test/test.dart';

void main() {
  group('GeoPoint', () {
    test('.fromLatLng() should create GeoPoint with latitude and longitude',
        () {
      const latitude = 1.0;
      const longitude = 1.0;
      final LatLng latLng = LatLng()
        ..longitude = longitude
        ..latitude = latitude;
      final expected = GeoPoint(latitude, longitude);
      final actual = GeoPoint.fromLatLng(latLng);
      expect(actual, expected);
    });
    test('.fromLatLng() throw NoSuchMethodError if LatLng is null', () {
      expect(() => GeoPoint.fromLatLng(null), throwsNoSuchMethodError);
    });
  });
}
