import 'package:firedart/src/auth/exception/firebase_auth_exception_code.dart';

/// A class that provides methods for mapping [FirebaseAuthExceptionCode]s.
class FirebaseAuthExceptionCodeMapper {
  /// An auth exception code indicating that the given Firebase API key
  /// is not valid.
  static const String invalidApiKey =
      'API key not valid. Please pass a valid API key.';

  /// An auth exception code indicating that the user with the given
  /// email is not found.
  static const String emailNotFound = 'EMAIL_NOT_FOUND';

  /// An auth exception code indicating that the given password is invalid.
  static const String invalidPassword = 'INVALID_PASSWORD';

  /// An auth exception code indicating that the password sign-in option
  /// is disabled in Firebase.
  static const String passwordLoginDisabled = 'PASSWORD_LOGIN_DISABLED';

  /// An auth exception code indicating that the user has been disabled
  /// (for example, in the Firebase console).
  static const String userDisabled = 'USER_DISABLED';

  /// An auth exception code indicating that there were too many attempts
  /// to sign in a user.
  static const String tooManyAttempts = 'TOO_MANY_ATTEMPTS_TRY_LATER';

  static FirebaseAuthExceptionCode map(String value) {
    switch (value) {
      case invalidApiKey:
        return FirebaseAuthExceptionCode.invalidApiKey;

      case emailNotFound:
        return FirebaseAuthExceptionCode.emailNotFound;

      case invalidPassword:
        return FirebaseAuthExceptionCode.invalidPassword;

      case passwordLoginDisabled:
        return FirebaseAuthExceptionCode.passwordLoginDisabled;

      case userDisabled:
        return FirebaseAuthExceptionCode.userDisabled;

      case tooManyAttempts:
        return FirebaseAuthExceptionCode.tooManyAttempts;

      default:
        return FirebaseAuthExceptionCode.unknown;
    }
  }
}
