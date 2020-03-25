import 'dart:typed_data';

import 'package:firedart/firedart.dart';
import 'package:firedart/src/generated/google/firestore/v1/document.pb.dart';
import 'package:firedart/src/generated/google/protobuf/struct.pb.dart' as fs;
import 'package:firedart/src/generated/google/protobuf/timestamp.pb.dart';
import 'package:firedart/src/generated/google/type/latlng.pb.dart';
import 'package:firedart/src/util/firestore_encoding.dart';
import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';

import '../test_utils/test_utils.dart';

void main() {
  group('FirestoreEncoding', () {
    const boolValueDart = true;
    const doubleValueDart = 1.0;
    const stringValueDart = 'stringValue';
    const integerValueDart = 1;
    final dateTimeValueDart = DateTime.fromMicrosecondsSinceEpoch(1000);
    final bytesValueDart = Uint8List.fromList([1]);
    const referencePath = 'doc/path';
    final documentReference =
        DocumentReference(FirestoreGatewayStub(), referencePath);
    final geoPoint = GeoPoint.fromLatLng(LatLng()
      ..latitude = 1.0
      ..longitude = 1.0);

    final nullValueFirestore = Value()..nullValue = fs.NullValue.NULL_VALUE;
    final booleanValueFirestore = Value()..booleanValue = boolValueDart;
    final doubleValueFirestore = Value()..doubleValue = doubleValueDart;
    final stringValueFirestore = Value()..stringValue = stringValueDart;
    final integerValueFirestore = Value()
      ..integerValue = Int64(integerValueDart);
    final timestampValueFirestore = Value()
      ..timestampValue = Timestamp.fromDateTime(
        dateTimeValueDart,
      );
    final bytesValueFirestore = Value()..bytesValue = bytesValueDart;
    final referenceValueFirestore = Value()
      ..referenceValue = documentReference.fullPath;
    final latLngValueFirestore = Value()..geoPointValue = geoPoint.toLatLng();
    final arrayValueFirestore = Value()
      ..arrayValue = (ArrayValue()..values.add(integerValueFirestore));
    final mapValueFirestore = Value()
      ..mapValue =
          (MapValue()..fields.addAll({stringValueDart: integerValueFirestore}));
    final unknownValueFirestore = Value();

    test('.encode() should return firestore null type from dart null type', () {
      final actual = FirestoreEncoding.encode(null);
      expect(actual, equals(nullValueFirestore));
    });
    test('.encode() should return firestore bool type from dart bool type', () {
      final actual = FirestoreEncoding.encode(boolValueDart);
      expect(actual, equals(booleanValueFirestore));
    });
    test('.encode() should return firestore double type from dart double type',
        () {
      final actual = FirestoreEncoding.encode(doubleValueDart);
      expect(actual, equals(doubleValueFirestore));
    });
    test('.encode() should return firestore string type from dart String type',
        () {
      final actual = FirestoreEncoding.encode(stringValueDart);
      expect(actual, equals(stringValueFirestore));
    });
    test('.encode() should return firestore int type from dart int type', () {
      final actual = FirestoreEncoding.encode(integerValueDart);
      expect(actual, equals(integerValueFirestore));
    });
    test(
        '.encode() should return firestore timestamp type from dart DateTime type',
        () {
      final actual = FirestoreEncoding.encode(dateTimeValueDart);
      expect(actual, equals(timestampValueFirestore));
    });
    test(
        '.encode() should return firestore bytes type from dart Uint8List type',
        () {
      final actual = FirestoreEncoding.encode(bytesValueDart);
      expect(actual, equals(bytesValueFirestore));
    });
    test(
        '.encode() should return firestore Reference type from DocumentReference type',
        () {
      final actual = FirestoreEncoding.encode(documentReference);
      expect(actual, equals(referenceValueFirestore));
    });
    test('.encode() should return firestore LatLng type from GeoPoint type',
        () {
      final actual = FirestoreEncoding.encode(geoPoint);
      expect(actual, equals(latLngValueFirestore));
    });
    test('.encode() should return firestore array type from dart List<T> type',
        () {
      final testList = [integerValueDart];
      final actual = FirestoreEncoding.encode(testList);
      expect(actual, equals(arrayValueFirestore));
    });
    test(
        '.encode() should return firestore map type from dart Map<String,T> type',
        () {
      final testMap = {stringValueDart: integerValueDart};
      final actual = FirestoreEncoding.encode(testMap);
      expect(actual, equals(mapValueFirestore));
    });
    test('.encode() should throw Exception trying to encode unknownType', () {
      expect(() => FirestoreEncoding.encode(unknownValueFirestore),
          throwsException);
    });
    test('.decode() should return dart null type from firestore null type', () {
      final actual = _decodeDelegate(nullValueFirestore);
      expect(actual, null);
    });
    test('.decode() should return dart bool type from firestore bool type', () {
      final actual = _decodeDelegate(booleanValueFirestore);
      expect(actual, boolValueDart);
    });
    test('.decode() should return dart double type from firestore double type',
        () {
      final actual = _decodeDelegate(doubleValueFirestore);
      expect(actual, doubleValueDart);
    });
    test('.decode() should return dart string type from firestore string type',
        () {
      final actual = _decodeDelegate(stringValueFirestore);
      expect(actual, stringValueDart);
    });
    test(
        '.decode() should return dart integer type from firestore integer type',
        () {
      final actual = _decodeDelegate(integerValueFirestore);
      expect(actual, integerValueDart);
    });
    test(
        '.decode() should return dart DateTime type from firestore timestamp type',
        () {
      final actual = _decodeDelegate(timestampValueFirestore);
      expect(actual, dateTimeValueDart);
    });
    test(
        '.decode() should return dart Uint8List type from firestore bytes type',
        () {
      final actual = _decodeDelegate(bytesValueFirestore);
      expect(actual, bytesValueDart);
    });
    test(
        '.decode() should return DocumentReference type from firestore reference type',
        () {
      final actual = _decodeDelegate(referenceValueFirestore);
      expect(actual, documentReference);
    });
    test('.decode() should return GeoPoint type from firestore LatLng type',
        () {
      final actual = _decodeDelegate(latLngValueFirestore);
      expect(actual, geoPoint);
    });
    test('.decode() should return dart List<T> type from firestore array type',
        () {
      final testList = [integerValueDart];
      final actual = _decodeDelegate(arrayValueFirestore);
      expect(actual, testList);
    });
    test(
        '.decode() should return dart Map<String,T> type from firestore map type',
        () {
      final testMap = {stringValueDart: integerValueDart};
      final actual = _decodeDelegate(mapValueFirestore);
      expect(actual, testMap);
    });
    test(
        '.decode() should throw Exception trying to decode unknown Firestore Value',
        () {
      expect(() => _decodeDelegate(unknownValueFirestore), throwsException);
    });
  });
}

dynamic _decodeDelegate(Value value) {
  return FirestoreEncoding.decode(value, FirestoreGatewayStub());
}
