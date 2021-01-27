import 'package:firedart/src/auth/mapper/firebase_auth_error_code_mapper.dart';

/// An exception thrown when the Firebase Authentication is failed.
class FirebaseAuthException implements Exception {
  /// An error code of this exception.
  final String code;

  /// A message containing extra information about this exception.
  final String message;

  const FirebaseAuthException(this.code, this.message);

  /// Creates a new instance of the [AuthException] with the given [code].
  ///
  /// Uses the [FirebaseAuthErrorCodeMapper] to map the given [code]
  /// into the human-readable [message].
  factory FirebaseAuthException.fromCode(String code) {
    final message = FirebaseAuthErrorCodeMapper.map(code);
    return FirebaseAuthException(code, message);
  }
}
