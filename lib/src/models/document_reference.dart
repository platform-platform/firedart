import 'package:firedart/src/firestore/firestore_gateway.dart';
import 'package:grpc/grpc.dart';

import 'collection_reference.dart';
import 'document.dart';
import 'reference.dart';

class DocumentReference extends Reference {
  DocumentReference(FirestoreGateway gateway, String path)
      : super(gateway, path) {
    if (fullPath.split('/').length % 2 == 0) {
      throw Exception('Path is not a document: $path');
    }
  }

  CollectionReference collection(String id) {
    return CollectionReference(gateway, '$path/$id');
  }

  Future<Document> get() => gateway.getDocument(fullPath);

  @Deprecated('Use the stream getter instead')
  Stream<Document> subscribe() => stream;

  Stream<Document> get stream => gateway.streamDocument(fullPath);

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
  Future<Document> create(Map<String, dynamic> map) => gateway.createDocument(
      fullPath.substring(0, fullPath.lastIndexOf('/')), id, encodeMap(map));

  /// Create or update a document.
  /// In the case of an update, any fields not referenced in the payload will be deleted.
  Future<void> set(Map<String, dynamic> map) async =>
      gateway.updateDocument(fullPath, encodeMap(map), update: false);

  /// Create or update a document.
  /// In case of an update, fields not referenced in the payload will remain unchanged.
  Future<void> update(Map<String, dynamic> map) =>
      gateway.updateDocument(fullPath, encodeMap(map), update: true);

  /// Deletes a document.
  Future<void> delete() async => gateway.deleteDocument(fullPath);
}
