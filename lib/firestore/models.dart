import 'package:firedart/generated/google/firestore/v1/document.pb.dart' as fs;
import 'package:firedart/generated/google/firestore/v1/query.pb.dart';
import 'package:firedart/generated/google/protobuf/struct.pb.dart';
import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:firedart/generated/google/protobuf/wrappers.pb.dart';
import 'package:firedart/generated/google/type/latlng.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import 'firestore_gateway.dart';

abstract class Reference {
  final FirestoreGateway _gateway;
  final String path;

  String get id => path.substring(path.lastIndexOf('/') + 1);

  String get _fullPath => '${_gateway.database}/$path';

  Reference(this._gateway, String path)
      : path = _trimSlashes(path.startsWith(_gateway.database)
            ? path.substring(_gateway.database.length + 1)
            : path);

  factory Reference.create(FirestoreGateway gateway, String path) {
    return _trimSlashes(path).split('/').length % 2 == 0
        ? DocumentReference(gateway, path)
        : CollectionReference(gateway, path);
  }

  @override
  bool operator ==(other) {
    return runtimeType == other.runtimeType && _fullPath == other._fullPath;
  }

  @override
  String toString() {
    return '$runtimeType: $path';
  }

  fs.Document _encodeMap(Map<String, dynamic> map) {
    var document = fs.Document();
    map.forEach((key, value) {
      document.fields[key] = _encode(value);
    });
    return document;
  }

  static String _trimSlashes(String path) {
    path = path.startsWith('/') ? path.substring(1) : path;
    return path.endsWith('/') ? path.substring(0, path.length - 2) : path;
  }
}

class CollectionReference extends Reference {
  StructuredQuery _structuredQuery;

  CollectionReference(FirestoreGateway gateway, String path)
      : super(gateway, path) {
    _structuredQuery = StructuredQuery();
    _structuredQuery.from
        .add(StructuredQuery_CollectionSelector()..collectionId = id);
    if (_fullPath.split('/').length % 2 == 1) {
      throw Exception('Path is not a collection: $path');
    }
  }

  DocumentReference document(String id) {
    return DocumentReference(_gateway, '$path/$id');
  }

  CollectionReference where(
    String fieldPath, {
    dynamic isEqualTo,
    dynamic isLessThan,
    dynamic isLessThanOrEqualTo,
    dynamic isGreaterThan,
    dynamic isGreaterThanOrEqualTo,
    dynamic arrayContains,
    List<dynamic> arrayContainsAny,
    List<dynamic> whereIn,
    bool isNull,
  }) {
    final compositeFilter = (_structuredQuery.hasWhere() &&
            _structuredQuery.where.hasCompositeFilter())
        ? _structuredQuery.where.compositeFilter
        : (StructuredQuery_CompositeFilter()
          ..op = StructuredQuery_CompositeFilter_Operator.AND);
    final filter = StructuredQuery_Filter();
    if (isNull != null) {
      if(!isNull){
        throw Exception(
            "'isNull': isNull can only be set to true. Use isEqualTo to filter on non-null values.");
      }
      final unaryFilter = StructuredQuery_UnaryFilter();
      unaryFilter.op = StructuredQuery_UnaryFilter_Operator.IS_NULL;
      unaryFilter.field_2 = StructuredQuery_FieldReference()..fieldPath = fieldPath;
      filter.unaryFilter = unaryFilter;
    }
    else {
      final fieldFilter = StructuredQuery_FieldFilter();
      if (isEqualTo != null) {
        fieldFilter.value = _encode(isEqualTo);
        fieldFilter.op = StructuredQuery_FieldFilter_Operator.EQUAL;
      } else if (isLessThan != null) {
        fieldFilter.value = _encode(isLessThan);
        fieldFilter.op = StructuredQuery_FieldFilter_Operator.LESS_THAN;
      } else if (isLessThanOrEqualTo != null) {
        fieldFilter.value = _encode(isLessThanOrEqualTo);
        fieldFilter.op =
            StructuredQuery_FieldFilter_Operator.LESS_THAN_OR_EQUAL;
      } else if (isGreaterThan != null) {
        fieldFilter.value = _encode(isGreaterThan);
        fieldFilter.op = StructuredQuery_FieldFilter_Operator.GREATER_THAN;
      } else if (isGreaterThanOrEqualTo != null) {
        fieldFilter.value = _encode(isGreaterThanOrEqualTo);
        fieldFilter.op =
            StructuredQuery_FieldFilter_Operator.GREATER_THAN_OR_EQUAL;
      } else if (arrayContains != null) {
        fieldFilter.value = _encode(arrayContains);
        fieldFilter.op = StructuredQuery_FieldFilter_Operator.ARRAY_CONTAINS;
      } else if (arrayContainsAny != null) {
        fieldFilter.value = _encode(arrayContainsAny);
        fieldFilter.op =
            StructuredQuery_FieldFilter_Operator.ARRAY_CONTAINS_ANY;
      } else if (whereIn != null) {
        fieldFilter.value = _encode(whereIn);
        fieldFilter.op = StructuredQuery_FieldFilter_Operator.IN;
      } else {
        throw Exception('Operator is not specified');
      }
      fieldFilter.field_1 = StructuredQuery_FieldReference()
        ..fieldPath = fieldPath;
      filter.fieldFilter = fieldFilter;
    }
    compositeFilter.filters.add(filter);
    _structuredQuery.where = StructuredQuery_Filter()
      ..compositeFilter = compositeFilter;
    return this;
  }

  CollectionReference orderBy(
    String fieldPath, {
    bool descending = false,
  }) {
    final order = StructuredQuery_Order();
    order.field_1 = StructuredQuery_FieldReference()..fieldPath = fieldPath;
    order.direction = descending
        ? StructuredQuery_Direction.DESCENDING
        : StructuredQuery_Direction.ASCENDING;
    _structuredQuery.orderBy.add(order);
    return this;
  }

  CollectionReference limit(int count) {
    _structuredQuery.limit = Int32Value()..value = count;
    return this;
  }

  Future<List<Document>> getDocuments() =>
      _gateway.runQuery(_structuredQuery, _fullPath);

  Stream<List<Document>> get stream => _gateway.streamCollection(_fullPath);

  /// Create a document with a random id.
  Future<Document> add(Map<String, dynamic> map) =>
      _gateway.createDocument(_fullPath, null, _encodeMap(map));
}

class DocumentReference extends Reference {
  DocumentReference(FirestoreGateway gateway, String path)
      : super(gateway, path) {
    if (_fullPath.split('/').length % 2 == 0) {
      throw Exception('Path is not a document: $path');
    }
  }

  CollectionReference collection(String id) {
    return CollectionReference(_gateway, '$path/$id');
  }

  Future<Document> get() => _gateway.getDocument(_fullPath);

  @Deprecated('Use the stream getter instead')
  Stream<Document> subscribe() => stream;

  Stream<Document> get stream => _gateway.streamDocument(_fullPath);

  /// Check if a document exists.
  Future<bool> get exists async {
    try {
      await get();
      return true;
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        return false;
      } else {
        rethrow;
      }
    }
  }

  /// Create a document if it doesn't exist, otherwise throw exception.
  Future<Document> create(Map<String, dynamic> map) => _gateway.createDocument(
      _fullPath.substring(0, _fullPath.lastIndexOf('/')), id, _encodeMap(map));

  /// Create or update a document.
  /// In the case of an update, any fields not referenced in the payload will be deleted.
  Future<void> set(Map<String, dynamic> map) async =>
      _gateway.updateDocument(_fullPath, _encodeMap(map), false);

  /// Create or update a document.
  /// In case of an update, fields not referenced in the payload will remain unchanged.
  Future<void> update(Map<String, dynamic> map) =>
      _gateway.updateDocument(_fullPath, _encodeMap(map), true);

  /// Deletes a document.
  Future<void> delete() async => await _gateway.deleteDocument(_fullPath);
}

class Document {
  final FirestoreGateway _gateway;
  final fs.Document _rawDocument;

  Document(this._gateway, this._rawDocument);

  String get id => path.substring(path.lastIndexOf('/') + 1);

  String get path =>
      _rawDocument.name.substring(_rawDocument.name.indexOf('/documents') + 10);

  Map<String, dynamic> get map =>
      _rawDocument.fields.map((key, _) => MapEntry(key, this[key]));

  DocumentReference get reference => DocumentReference(_gateway, path);

  dynamic operator [](String key) {
    if (!_rawDocument.fields.containsKey(key)) return null;
    return _decode(_rawDocument.fields[key], _gateway);
  }

  @override
  String toString() => '$path $map';
}

class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint(this.latitude, this.longitude);

  GeoPoint._internal(LatLng value) : this(value.latitude, value.longitude);

  @override
  bool operator ==(other) =>
      runtimeType == other.runtimeType &&
      latitude == other.latitude &&
      longitude == other.longitude;

  @override
  String toString() => 'lat: $latitude, lon: $longitude';

  LatLng _toLatLng() => LatLng()
    ..latitude = latitude
    ..longitude = longitude;
}

fs.Value _encode(dynamic value) {
  if (value == null) return fs.Value()..nullValue = NullValue.NULL_VALUE;

  var type = value.runtimeType;

  if (type.toString().startsWith('List')) {
    var array = fs.ArrayValue();
    (value as List).forEach((element) => array.values.add(_encode(element)));
    return fs.Value()..arrayValue = array;
  }

  if (type.toString().contains('Map')) {
    var map = fs.MapValue();
    (value as Map).forEach((key, val) => map.fields[key] = _encode(val));
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
      return fs.Value()..geoPointValue = (value as GeoPoint)._toLatLng();
    default:
      throw Exception('Unknown type: ${type}');
  }
}

dynamic _decode(fs.Value value, FirestoreGateway gateway) {
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
      return GeoPoint._internal(value.geoPointValue);
    case fs.Value_ValueType.arrayValue:
      return value.arrayValue.values
          .map((item) => _decode(item, gateway))
          .toList(growable: false);
    case fs.Value_ValueType.mapValue:
      return value.mapValue.fields
          .map((key, value) => MapEntry(key, _decode(value, gateway)));
    default:
      throw Exception('Unrecognized type: ${value}');
  }
}
