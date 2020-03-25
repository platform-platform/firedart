import 'package:firedart/firedart.dart';
import 'package:test/test.dart';
import 'package:firedart/src/generated/google/firestore/v1/query.pb.dart';
import 'package:firedart/src/generated/google/protobuf/wrappers.pb.dart';
import 'package:firedart/src/util/firestore_encoding.dart';

import '../test_utils/test_utils.dart';

void main() {
  group('CollectionReference', () {
    final collectionReference = _CollectionReferenceStub('test');


    test(
        'CollectionReference() should add new StructuredQuery_CollectionSelector to StructuredQuery.from field',
        () {
      expect(_testCollectionSelector,
          collectionReference.structuredQuery.from.first);
    });
    test(
        '.where(fieldPath,{}) should add new StructuredQuery_Filter to StructuredQuery.where.compositeFilter field',
        () {
      collectionReference.where('fieldPath', isEqualTo: 1);
      expect(_testCompositeFilter,
          equals(collectionReference.structuredQuery.where.compositeFilter));
    });
    test(
      '.limit() should set value StructuredQuery.limit field',
      () {
        final structuredQuery = collectionReference.limit(1).structuredQuery;
        expect(_testLimit, structuredQuery.limit);
      },
    );
    test(
      '.orderBy(fieldPath,{descending=false}) should add new StructuredQuery_OrderBy to StructuredQuery.orderBy field',
      () {
        final structuredQuery =
            collectionReference.orderBy('fieldPath').structuredQuery;
        expect(_testOrderBy, structuredQuery.orderBy.first);
      },
    );
    test('.document(path) shoud create DocumentReference with new path', () {
      final documentReference = collectionReference.document('testPath');
      expect(documentReference.id, 'testPath');
      expect(
        documentReference.runtimeType,
        equals(DocumentReference),
      );
    });
  });
}

class _CollectionReferenceStub extends CollectionReference {
  _CollectionReferenceStub(String path) : super(FirestoreGatewayStub(), path);
}

const StructuredQuery_CompositeFilter_Operator _filterOperator =
    StructuredQuery_CompositeFilter_Operator.AND;
const StructuredQuery_FieldFilter_Operator _fieldFilterOperator =
    StructuredQuery_FieldFilter_Operator.EQUAL;
const StructuredQuery_Direction _orderByDirection =
    StructuredQuery_Direction.ASCENDING;
const int _value = 1;
const String _fieldPath = 'fieldPath';

StructuredQuery_CollectionSelector _testCollectionSelector =
StructuredQuery_CollectionSelector()..collectionId = 'test';
StructuredQuery_CompositeFilter _testCompositeFilter =
StructuredQuery_CompositeFilter()
  ..op = _filterOperator
  ..filters.add(
    StructuredQuery_Filter()
      ..fieldFilter = (StructuredQuery_FieldFilter()
        ..op = _fieldFilterOperator
        ..value = FirestoreEncoding.encode(_value)
        ..field_1 =
        (StructuredQuery_FieldReference()..fieldPath = _fieldPath)),
  );
StructuredQuery_Order _testOrderBy = StructuredQuery_Order()
  ..field_1 = (StructuredQuery_FieldReference()..fieldPath = _fieldPath)
  ..direction = _orderByDirection;
Int32Value _testLimit = Int32Value()..value = _value;