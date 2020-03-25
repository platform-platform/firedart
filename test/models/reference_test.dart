import 'package:firedart/firedart.dart';
import 'package:test/test.dart';

import '../test_utils/test_utils.dart';

void main() {
  group('Reference', () {
    test(
        '.create() should create DocumentRefrence if the number of slashes in the path is odd',
        () {
      final reference = Reference.create(FirestoreGatewayStub(), 'doc/path');
      expect(reference.runtimeType, equals(DocumentReference));
    });
    test(
        '.create() should create CollectionReference if the number of slashes in the path is even',
        () {
      final reference =
          Reference.create(FirestoreGatewayStub(), 'collectionPath');
      expect(reference.runtimeType, equals(CollectionReference));
    });
    test('check that reference id is equal to last string after /', () {
      const expected = 'path';
      final reference =
          Reference.create(FirestoreGatewayStub(), 'doc/$expected');
      expect(reference.id, expected);
    });
    test(
        'check that reference fullPath is equal to database path + reference path',
        () {
      const referencePath = 'doc/path';
      final firestoreGateway = FirestoreGatewayStub();
      final reference = Reference.create(firestoreGateway, referencePath);
      expect(reference.fullPath, '${firestoreGateway.database}/$referencePath');
    });
    test(
        'check that path of reference is normal, when create heir of Reference class via database path + reference path',
        () {
      const docReferencePath = 'doc/path';
      final firestoreGateway = FirestoreGatewayStub();
      final reference = DocumentReference(
          firestoreGateway, '${firestoreGateway.database}/$docReferencePath');
      expect(reference.path, docReferencePath);
    });
    test('.create() throw NoSuchMethodError trying to create Reference with null path',(){
      expect(()=>Reference.create(FirestoreGatewayStub(), null), throwsNoSuchMethodError);
    });
  });
}
