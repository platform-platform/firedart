import 'package:firedart/firedart.dart';
import 'package:test/test.dart';

import '../test_config.dart';
import '../test_data/collection_test_data.dart';

void main() {
  group('CollectionReference', () {
    final collectionReference = CollectionReferenceStub('test');

    test(
        'CollectionReference() should add new StructuredQuery_CollectionSelector to StructuredQuery.from field',
        () {
      expect(CollectionTestData.collectionSelector,
          collectionReference.structuredQuery.from.first);
    });
    test(
        '.where(fieldPath,{}) should add new StructuredQuery_Filter to StructuredQuery.where.compositeFilter field',
        () {
      collectionReference.where('fieldPath', isEqualTo: 1);
      expect(CollectionTestData.testCompositeFilter,
          equals(collectionReference.structuredQuery.where.compositeFilter));
    });
    test(
      '.limit(n) should set StructuredQuery.limit field to n',
      () {
        final structuredQuery = collectionReference.limit(1).structuredQuery;
        expect(CollectionTestData.testLimit, structuredQuery.limit);
      },
    );
    test(
      '.orderBy(fieldPath,{descending=false}) should add new StructuredQuery_OrderBy to StructuredQuery.orderBy field',
      () {
        final structuredQuery =
            collectionReference.orderBy('fieldPath').structuredQuery;
        expect(CollectionTestData.testOrderBy, structuredQuery.orderBy.first);
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

class CollectionReferenceStub extends CollectionReference {
  CollectionReferenceStub(String path) : super(FirestoreGatewayStub(), path);
}
