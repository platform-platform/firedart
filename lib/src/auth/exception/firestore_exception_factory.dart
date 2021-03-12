import 'package:firedart/src/auth/exception/firestore_exception.dart';
import 'package:firedart/src/auth/mapper/firestore_exception_code_mapper.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_web.dart';
import 'package:protobuf/protobuf.dart';

/// A factory for the Firestore exception.
///
/// Used to create an instance of the [FirestoreException] using the [GrpcError].
class FirestoreExceptionFactory {
  /// Creates a new instance of the [FirestoreException] using the given [error].
  static FirestoreException create(GrpcError error) {
    final exceptionCode = FirestoreExceptionCodeMapper.map(error.codeName);

    final exceptionReasons = _getExceptionReasons(error.details);

    final exceptionMessage = error.message;

    return FirestoreException(
      exceptionCode,
      exceptionReasons,
      exceptionMessage,
    );
  }

  /// Creates a [List] of error reasons from the given [errorDetails].
  static List<String> _getExceptionReasons(
    List<GeneratedMessage> errorDetails,
  ) {
    final errorInfo = errorDetails.whereType<ErrorInfo>();

    return errorInfo.map((info) => info.reason).toList();
  }
}
