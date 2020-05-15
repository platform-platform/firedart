import 'package:firedart/src/auth/constants/auth_error_code.dart';
import 'package:firedart/src/auth/exception/auth_exception.dart';

/// A mapper for the [AuthException] error codes.
class AuthErrorCodeMapper {
  /// Maps the given [code] into the human-readable error description using
  /// the codes presented in [AuthErrorCode].
  static String map(String code) {
    switch (code) {
      case AuthErrorCode.invalidEmail:
        return 'The email address is badly formatted.';
      case AuthErrorCode.wrongPasswrod:
        return 'The password is invalid or the user does not have a password.';
      case AuthErrorCode.userNotFound:
        return 'There is no user record corresponding to this identifier.'
            'The user may have been deleted.';
      case AuthErrorCode.userDisabled:
        return 'The user account has been disabled by an administrator.';
      case AuthErrorCode.tooManyRequests:
        return 'We have blocked all requests from this device due to unusual '
            'activity. Try again later.';
      case AuthErrorCode.operationNotAllowed:
        return 'This operation is not allowed. Enable the sign-in method in the '
            'Authentication tab of the Firebase console.';
      default:
        return 'Unknown error $code';
    }
  }
}
