import 'package:firedart/firedart.dart';
import 'package:firedart/src/generated/google/firestore/v1/document.pb.dart'
    as fs;
import 'package:firedart/src/generated/google/protobuf/struct.pbenum.dart';
import 'package:firedart/src/generated/google/protobuf/timestamp.pb.dart';
import 'package:firedart/src/firestore/firestore_gateway.dart';
import 'package:fixnum/fixnum.dart';

abstract class FirestoreEncoding {
  static fs.Value encode(dynamic value) {
    if (value == null) return fs.Value()..nullValue = NullValue.NULL_VALUE;

    var type = value.runtimeType;

    if (type.toString().startsWith('List')) {
      var array = fs.ArrayValue();
      (value as List).forEach((element) => array.values.add(encode(element)));
      return fs.Value()..arrayValue = array;
    }

    if (type.toString().contains('Map')) {
      var map = fs.MapValue();
      (value as Map).forEach((key, val) => map.fields[key] = encode(val));
      return fs.Value()..mapValue = map;
    }

    if (type.toString() == 'Uint8List') {
      return fs.Value()..bytesValue = value;
    }

    switch (type) {
      case bool:
        return fs.Value()..booleanValue = value;
      case int:
        return fs.Value()..integerValue = Int64(value);
      case double:
        return fs.Value()..doubleValue = value;
      case DateTime:
        return fs.Value()..timestampValue = Timestamp.fromDateTime(value);
      case String:
        return fs.Value()..stringValue = value;
      case DocumentReference:
        return fs.Value()..referenceValue = value._fullPath;
      case GeoPoint:
        return fs.Value()..geoPointValue = (value as GeoPoint).toLatLng();
      default:
        throw Exception('Unknown type: ${type}');
    }
  }

  static dynamic decode(fs.Value value, FirestoreGateway gateway) {
    switch (value.whichValueType()) {
      case fs.Value_ValueType.nullValue:
        return null;
      case fs.Value_ValueType.booleanValue:
        return value.booleanValue;
      case fs.Value_ValueType.doubleValue:
        return value.doubleValue;
      case fs.Value_ValueType.stringValue:
        return value.stringValue;
      case fs.Value_ValueType.integerValue:
        return value.integerValue.toInt();
      case fs.Value_ValueType.timestampValue:
        return value.timestampValue.toDateTime().toLocal();
      case fs.Value_ValueType.bytesValue:
        return value.bytesValue;
      case fs.Value_ValueType.referenceValue:
        return DocumentReference(gateway, value.referenceValue);
      case fs.Value_ValueType.geoPointValue:
        return GeoPoint.fromLatLng(value.geoPointValue);
      case fs.Value_ValueType.arrayValue:
        return value.arrayValue.values
            .map((item) => decode(item, gateway))
            .toList(growable: false);
      case fs.Value_ValueType.mapValue:
        return value.mapValue.fields
            .map((key, value) => MapEntry(key, decode(value, gateway)));
      default:
        throw Exception('Unrecognized type: ${value}');
    }
  }
}
