import 'package:firedart/src/auth/mapper/auth_error_code_mapper.dart';

/// Exception thrown when the authentication is failed.
class AuthException implements Exception {
  /// The error code of the exception.
  final String code;

  /// A message containing extra information about the exception.
  final String message;

  const AuthException(this.code, this.message);

  /// Creates an instance of [AuthException] parsing the [message]
  /// from the given [code] using the [AuthErrorCodeMapper].
  factory AuthException.fromCode(String code) {
    final message = AuthErrorCodeMapper.map(code);
    return AuthException(code, message);
  }
}
