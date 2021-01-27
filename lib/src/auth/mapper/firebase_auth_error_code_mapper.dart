import 'package:firedart/src/auth/constants/firebase_auth_error_code.dart';
import 'package:firedart/src/auth/exception/firebase_auth_exception.dart';

/// A mapper for the [FirebaseAuthException] error codes.
class FirebaseAuthErrorCodeMapper {
  /// Maps the given [code] into the human-readable error description.
  static String map(String code) {
    switch (code) {
      case FirebaseAuthErrorCode.invalidEmail:
        return 'The email address is badly formatted.';
      case FirebaseAuthErrorCode.wrongPassword:
        return 'The password is invalid or the user does not have a password.';
      case FirebaseAuthErrorCode.userNotFound:
        return 'There is no user record corresponding to this identifier. '
            'The user may have been deleted.';
      case FirebaseAuthErrorCode.userDisabled:
        return 'The user account has been disabled by an administrator.';
      case FirebaseAuthErrorCode.tooManyRequests:
        return 'We have blocked all requests from this device due to unusual '
            'activity. Try again later.';
      case FirebaseAuthErrorCode.operationNotAllowed:
        return 'This operation is not allowed. Enable the sign-in method in '
            'the Authentication tab of the Firebase console.';
      default:
        return 'An unknown error occurred with the following code: $code. '
            'Please check your Internet connection and try again later.';
    }
  }
}
