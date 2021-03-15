import 'package:firedart/src/repository/exception/firestore_exception.dart';

/// Represents an exception code of the [FirestoreException].
enum FirestoreExceptionCode {
  /// An exception code indicating that the operation was cancelled.
  cancelled,

  /// A code that indicates an unknown exception.
  unknown,

  /// An exception code indicating that the client specified an invalid argument.
  invalidArgument,

  /// An exception code indicating that the deadline expired before the 
  /// operation could complete.
  deadlineExceeded,

  /// An exception code indicating that some requested entity was not found.
  notFound,

  /// An exception code indicating that the entity that a client attempted 
  /// to create already exists.
  alreadyExists,

  /// An exception code indicating that the caller does not have permission to 
  /// execute the specified operation.
  permissionDenied,

  /// An exception code indicating that the request does not have valid 
  /// authentication credentials for the operation.
  unauthenticated,

  /// An exception code indicating that some resource has been exhausted.
  resourceExhausted,

  /// An exception code indicating that the operation was rejected because the 
  /// system is not in a state required for the operation's execution.
  failedPrecondition,

  /// An exception code indicating that the operation was aborted.
  aborted,

  /// An exception code indicating that the operation was attempted past the 
  /// valid range.
  outOfRange,

  /// An exception code indicating that the operation is not yet implemented.
  unimplemented,

  /// An exception code indicating that the internal errors occurred in 
  /// Firestore.
  internal,

  /// An exception code indicating that the Firestore services are currently 
  /// unavailable.
  unavailable,

  /// An exception code indicating that the unrecoverable data loss or 
  /// corruption occurred during the request.
  dataLoss,
}
