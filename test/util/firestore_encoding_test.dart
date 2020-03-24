import 'package:firedart/src/util/firestore_encoding.dart';
import 'package:test/test.dart';

import '../test_config.dart';
import '../test_data/util_test_data.dart';

void main() {
  group('FirestoreEncoding', () {
    test('.encode(value) should return firestore Value Object from dart Object',
        () {
      final expected = UtilTestData.booleanValue;
      final actual = FirestoreEncoding.encode(true);
      expect(actual, equals(expected));
    });
    test(
        '.decode(value, gateway) should return dart Object from firestore Value Object',
        () {
      final expected = true;
      final actual = FirestoreEncoding.decode(
          UtilTestData.booleanValue, FirestoreGatewayStub());
      expect(actual, equals(expected));
    });
    test('.encode(value) should throw Exception trying to encode unknownType', (){
      expect(()=>FirestoreEncoding.encode(UtilTestData.unknownValue), throwsException);
    });
    test('.decode(value, gateway) should throw Exception trying to decode unknown Firestore Value', (){
      expect(()=>FirestoreEncoding.decode(UtilTestData.unknownValue, FirestoreGatewayStub()), throwsException);
    });
  });
}
