import 'package:firedart/src/auth/exception/firebase_auth_exception_code.dart';

/// A class that provides methods for mapping [FirebaseAuthExceptionCode]s into
/// human-readable messages.
class FirebaseAuthExceptionMessageMapper {
  /// Maps the given [code] into the human-readable error description.
  static String map(FirebaseAuthExceptionCode code) {
    switch (code) {
      case FirebaseAuthExceptionCode.invalidApiKey:
        return 'The Firebase API key is invalid.';

      case FirebaseAuthExceptionCode.emailNotFound:
        return 'There is no user record corresponding to this identifier. '
            'The user may have been deleted.';

      case FirebaseAuthExceptionCode.invalidPassword:
        return 'The password is invalid or the user does not have a password.';

      case FirebaseAuthExceptionCode.passwordLoginDisabled:
        return 'The option to login via the password is disabled.';

      case FirebaseAuthExceptionCode.userDisabled:
        return 'The user account has been disabled by an administrator.';

      case FirebaseAuthExceptionCode.tooManyAttempts:
        return 'We have blocked all requests from this device due to unusual '
            'activity. Try again later.';

      case FirebaseAuthExceptionCode.unknown:
        return 'An unknown error occurred. '
            'Please check your Internet connection and try again later.';
    }
    return null;
  }
}
