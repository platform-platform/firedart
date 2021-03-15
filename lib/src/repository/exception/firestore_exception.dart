import 'package:firedart/src/repository/exception/firestore_exception_code.dart';

/// An exception thrown when the Firestore operation is failed.
class FirestoreException implements Exception {
  /// A [FirestoreExceptionCode] of this exception.
  final FirestoreExceptionCode code;

  /// A [List] containing all reasons of this exception.
  final List<String> reasons;

  /// A message containing extra information about this exception.
  final String message;

  /// Creates a new instance of the [FirestoreException] with the given
  /// parameters.
  const FirestoreException(this.code, this.reasons, this.message);
}
