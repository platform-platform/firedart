import 'package:firedart/src/repository/exception/firestore_exception.dart';
import 'package:firedart/src/repository/mapper/firestore_exception_code_mapper.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/protobuf.dart';

/// A factory class that creates a new instance of the [FirestoreException]
/// using the [GrpcError].
class FirestoreExceptionFactory {
  /// Creates a new instance of the [FirestoreException] using the given [error].
  static FirestoreException create(GrpcError error) {
    final exceptionCode = FirestoreExceptionCodeMapper.map(error.codeName);
    final exceptionReasons = _extractReasons(error.details);
    final exceptionMessage = error.message;

    return FirestoreException(
      exceptionCode,
      exceptionReasons,
      exceptionMessage,
    );
  }

  /// Extracts a [List] of error reasons from the given [errorDetails].
  static List<String> _extractReasons(
    List<GeneratedMessage> errorDetails,
  ) {
    final errorInfo = errorDetails.whereType<ErrorInfo>();

    return errorInfo.map((info) => info.reason).toList();
  }
}
