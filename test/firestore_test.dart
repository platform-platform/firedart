import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:test/test.dart';

import 'test_config.dart.EDIT';

Future main() async {
  final apiKey = TestConfig.apiKey;
  final projectId = TestConfig.projectId;
  final email = TestConfig.email;
  final password = TestConfig.password;

  final tokenStore = VolatileStore();
  final auth = FirebaseAuth(apiKey, tokenStore);
  final firestore = Firestore(projectId, auth: auth);

  Future<bool> documentExists(DocumentReference documentReference) async {
    return documentReference.get().then((document) => document.exists);
  }

  setUpAll(() async {
    await auth.signIn(email, password);
  });

  test("Create reference", () async {
    // Ensure document exists
    final reference = firestore.document('test/reference');
    await reference.set({'field': 'test'});
    addTearDown(() => reference.delete());

    final collectionReference = firestore.reference('test');
    expect(collectionReference, isA<CollectionReference>());

    final documentReference = firestore.reference('test/types');
    expect(documentReference, isA<DocumentReference>());
  });

  test("Get collection", () async {
    final reference = firestore.collection('test');

    final document = await reference.add({'field': 'test'});
    addTearDown(() => document.reference.delete());

    final documents = await reference.getDocuments();

    expect(documents, isNotEmpty);
  });

  test("Add and delete collection document", () async {
    final collection = firestore.collection('test');
    final document = await collection.add({'field': 'test'});
    expect(document['field'], 'test');

    final docReference = collection.document(document.id);
    expect(documentExists(docReference), completion(isTrue));

    await docReference.delete();
    expect(documentExists(docReference), completion(isFalse));
  });

  test("Add and delete named document", () async {
    final docReference = firestore.document('test/add_remove');

    await docReference.set({'field': 'test'});
    expect(documentExists(docReference), completion(isTrue));

    await docReference.delete();
    expect(documentExists(docReference), completion(isFalse));
  });

  test("Path with leading slash", () async {
    final docReference = firestore.document('/test/path');

    await docReference.set({'field': 'test'});
    expect(documentExists(docReference), completion(isTrue));

    await docReference.delete();
    expect(documentExists(docReference), completion(isFalse));
  });

  test("Path with trailing slash", () async {
    final docReference = firestore.document('test/path/');

    await docReference.set({'field': 'test'});
    expect(documentExists(docReference), completion(isTrue));

    await docReference.delete();
    expect(documentExists(docReference), completion(isFalse));
  });

  test("Path with leading and trailing slashes", () async {
    final docReference = firestore.document('/test/path/');

    await docReference.set({'field': 'test'});
    expect(documentExists(docReference), completion(isTrue));

    await docReference.delete();
    expect(documentExists(docReference), completion(isFalse));
  });

  test("Read data from document", () async {
    final reference = firestore.collection('test').document('read_data');

    await reference.set({'field': 'test'});
    addTearDown(() => reference.delete());

    final document = await reference.get();
    expect(document['field'], equals('test'));
  });

  test("Overwrite document", () async {
    final reference = firestore.collection('test').document('overwrite');
    await reference.set({'field1': 'test1', 'field2': 'test1'});
    await reference.set({'field1': 'test2'});
    addTearDown(() => reference.delete());

    final document = await reference.get();

    expect(document['field1'], equals('test2'));
    expect(document['field2'], isNull);
  });

  test("Update document", () async {
    final reference = firestore.collection('test').document('update');
    await reference.set({'field1': 'test1', 'field2': 'test1'});
    await reference.update({'field1': 'test2'});
    addTearDown(() => reference.delete());

    final document = await reference.get();

    expect(document['field1'], equals('test2'));
    expect(document['field2'], equals('test1'));
  });

  test("Stream document changes", () async {
    final reference = firestore.document('test/subscribe');

    // Firestore may send empty events on subscription because we're reusing the
    // document path.
    expect(
      reference.stream.where((doc) => doc != null),
      emits((document) => document['field'] == 'test'),
    );

    await reference.set({'field': 'test'});
    addTearDown(() => reference.delete());
  });

  test("Stream collection changes", () async {
    final reference = firestore.collection('test');

    final document = await reference.add({'field': 'test'});
    addTearDown(() => document.reference.delete());

    expect(reference.stream, emits(isNotEmpty));
  });

  test("Document field types", () async {
    final reference = firestore.collection('test').document('types');
    final testMap = {
      'null': null,
      'bool': true,
      'int': 1,
      'double': 0.1,
      'timestamp': DateTime.now(),
      'bytes': utf8.encode('byte array'),
      'string': 'text',
      'reference': reference,
      'coordinates': const GeoPoint(38.7223, 9.1393),
      'list': [1, 'text'],
      'map': {'int': 1, 'string': 'text'},
    };

    await reference.set(testMap);
    addTearDown(() => reference.delete());

    final document = await reference.get();
    expect(document['null'], equals(testMap['null']));
    expect(document['bool'], equals(testMap['bool']));
    expect(document['int'], equals(testMap['int']));
    expect(document['double'], equals(testMap['double']));
    expect(document['timestamp'], equals(testMap['timestamp']));
    expect(document['bytes'], equals(testMap['bytes']));
    expect(document['string'], equals(testMap['string']));
    expect(document['reference'], equals(testMap['reference']));
    expect(document['coordinates'], equals(testMap['coordinates']));
    expect(document['list'], equals(testMap['list']));
    expect(document['map'], equals(testMap['map']));
  });

  test("Refresh token when expired", () async {
    tokenStore.expireToken();
    final documents = await firestore.collection('test').getDocuments();

    expect(documents, isNotNull);
    expect(auth.isSignedIn, isTrue);
  });

  test("Sign out on bad refresh token", () async {
    tokenStore.setToken('user_id', 'bad_token', 'bad_token', 0);
    final result = firestore.collection('test').getDocuments();

    await expectLater(result, throwsA(anything));
    expect(auth.isSignedIn, isFalse);
  });
}
