import 'package:firedart/src/repository/exception/firestore_exception_code.dart';

/// A class that provides methods for mapping [FirestoreExceptionCode]s.
class FirestoreExceptionCodeMapper {
  /// An exception code indicating whether the operation was cancelled.
  static const String cancelled = 'CANCELLED';

  /// An exception code indicating whether the client specified an invalid argument.
  static const String invalidArgument = 'INVALID_ARGUMENT';

  /// An exception code indicating whether the deadline expired before the operation could
  /// complete.
  static const String deadlineExceeded = 'DEADLINE_EXCEEDED';

  /// An exception code indicating whether some requested entity was not found.
  static const String notFound = 'NOT_FOUND';

  /// An exception code indicating whether the entity that a client attempted to create
  /// already exists.
  static const String alreadyExists = 'ALREADY_EXISTS';

  /// An exception code indicating whether the caller does not have permission to execute the
  /// specified operation.
  static const String permissionDenied = 'PERMISSION_DENIED';

  /// An exception code indicating whether the request does not have valid authentication
  /// credentials for the operation.
  static const String unauthenticated = 'UNAUTHENTICATED';

  /// An exception code indicating whether some resource has been exhausted.
  static const String resourceExhausted = 'RESOURCE_EXHAUSTED';

  /// An exception code indicating whether the operation was rejected because the system is not in
  /// a state required for the operation's execution.
  static const String failedPrecondition = 'FAILED_PRECONDITION';

  /// An exception code indicating whether the operation was aborted.
  static const String aborted = 'ABORTED';

  /// An exception code indicating whether the operation was attempted past the valid range.
  static const String outOfRange = 'OUT_OF_RANGE';

  /// An exception code indicating whether the operation is not yet implemented.
  static const String unimplemented = 'UNIMPLEMENTED';

  /// An exception code indicating whether the internal errors occurred in Firestore.
  static const String internal = 'INTERNAL';

  /// An exception code indicating whether the Firestore services are currently unavailable.
  static const String unavailable = 'UNAVAILABLE';

  /// An exception code indicating whether the unrecoverable data loss or corruption occurred
  /// during the request.
  static const String dataLoss = 'DATA_LOSS';

  /// Maps the given [code] into the [FirestoreExceptionCode].
  static FirestoreExceptionCode map(String code) {
    switch (code) {
      case cancelled:
        return FirestoreExceptionCode.cancelled;

      case invalidArgument:
        return FirestoreExceptionCode.invalidArgument;

      case deadlineExceeded:
        return FirestoreExceptionCode.deadlineExceeded;

      case notFound:
        return FirestoreExceptionCode.notFound;

      case alreadyExists:
        return FirestoreExceptionCode.alreadyExists;

      case permissionDenied:
        return FirestoreExceptionCode.permissionDenied;

      case unauthenticated:
        return FirestoreExceptionCode.unauthenticated;

      case resourceExhausted:
        return FirestoreExceptionCode.resourceExhausted;

      case failedPrecondition:
        return FirestoreExceptionCode.failedPrecondition;

      case aborted:
        return FirestoreExceptionCode.aborted;

      case outOfRange:
        return FirestoreExceptionCode.outOfRange;

      case unimplemented:
        return FirestoreExceptionCode.unimplemented;

      case internal:
        return FirestoreExceptionCode.internal;

      case unavailable:
        return FirestoreExceptionCode.unavailable;

      case dataLoss:
        return FirestoreExceptionCode.dataLoss;

      default:
        return FirestoreExceptionCode.unknown;
    }
  }
}
