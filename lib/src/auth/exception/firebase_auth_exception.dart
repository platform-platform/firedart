import 'package:firedart/src/auth/exception/firebase_auth_exception_code.dart';
import 'package:firedart/src/auth/mapper/firebase_auth_exception_message_mapper.dart';
import 'package:firedart/src/auth/mapper/firebase_auth_exception_code_mapper.dart';

/// An exception thrown when the Firebase Authentication is failed.
class FirebaseAuthException implements Exception {
  /// A [FirebaseAuthExceptionCode] of this exception.
  final FirebaseAuthExceptionCode code;

  /// A message containing extra information about this exception.
  final String message;

  /// Creates a new instance of the [FirebaseAuthException] with the given
  /// [code] and [message].
  const FirebaseAuthException(this.code, this.message);

  /// Creates a new instance of the [FirebaseAuthException] using the given
  /// [code].
  ///
  /// Uses the [FirebaseAuthExceptionCodeMapper] and 
  /// [FirebaseAuthExceptionMessageMapper] to map the 
  /// [FirebaseAuthExceptionCode] and create a [message] respectively.
  factory FirebaseAuthException.fromCode(String code) {
    final exceptionCode = FirebaseAuthExceptionCodeMapper.map(code);
    final message = FirebaseAuthExceptionMessageMapper.map(exceptionCode);

    return FirebaseAuthException(exceptionCode, message);
  }
}
