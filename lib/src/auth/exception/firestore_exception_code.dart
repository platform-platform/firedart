import 'package:firedart/src/auth/exception/firestore_exception.dart';

/// Represents an exception code of the [FirestoreException].
enum FirestoreExceptionCode {
  /// Indicates whether the operation was cancelled.
  cancelled,

  /// Indicates whether the exception is unknown.
  unknown,

  /// Indicates whether the client specified an invalid argument.
  invalidArgument,

  /// Indicates whether the deadline expired before the operation could
  /// complete.
  deadlineExceeded,

  /// Indicates whether some requested entity was not found.
  notFound,

  /// Indicates whether the entity that a client attempted to create
  /// already exists.
  alreadyExists,

  /// Indicates whether the caller does not have permission to execute the
  /// specified operation.
  permissionDenied,

  /// Indicates whether the request does not have valid authentication
  /// credentials for the operation.
  unauthenticated,

  /// Indicates whether some resource has been exhausted.
  resourceExhausted,

  /// Indicates whether the operation was rejected because the system is not in
  /// a state required for the operation's execution.
  failedPrecondition,

  /// Indicates whether the operation was aborted.
  aborted,

  /// Indicates whether the operation was attempted past the valid range.
  outOfRange,

  /// Indicates whether the operation is not yet implemented.
  unimplemented,

  /// Indicates whether the internal errors occurred in Firestore.
  internal,

  /// Indicates whether the Firestore services are currently unavailable.
  unavailable,

  /// Indicates whether the unrecoverable data loss or corruption occurred
  /// during the request.
  dataLoss,
}
