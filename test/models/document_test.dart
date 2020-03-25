import 'package:firedart/firedart.dart';
import 'package:firedart/src/generated/google/firestore/v1/document.pb.dart'
    as fs;
import 'package:test/test.dart';

import '../test_utils/test_utils.dart';

void main() {
  group('Document', () {
    const key = 'field';
    const stringValue = 'stringValue';
    const documentId = 'documentId';
    const documentPath = 'documentPath/$documentId';
    const fsDocumentName = '/documents$documentPath';
    final firestoreStringValue = fs.Value()..stringValue = stringValue;
    final fsDocument = fs.Document()
      ..fields.addAll({key: firestoreStringValue})
      ..name = fsDocumentName;
    final document = Document(FirestoreGatewayStub(), fsDocument);
    test('Document path should be equal to string after /documents', () {
      expect(document.path, documentPath);
    });
    test('Document id should be equal to last string after /', () {
      expect(document.id, documentId);
    });
    test('[] operator should return decoded dart value by string key', () {
      expect(
          document[key],
          stringValue
      );
    });
    test("[] operator should return null if key doesn't exists", () {
      expect(document['not existed key'], null);
    });
  });
}
