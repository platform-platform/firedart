/// A class that holds Firebase Authentication error codes.
class FirebaseAuthErrorCode {
  /// An error code that indicates a malformed email address error.
  static const String invalidEmail = 'ERROR_INVALID_EMAIL';

  /// An error code that indicates a wrong password error.
  static const String wrongPassword = 'ERROR_WRONG_PASSWORD';

  /// An error code that indicates when there is no user corresponding
  /// to the given email address, or if the user has been deleted.
  static const String userNotFound = 'ERROR_USER_NOT_FOUND';

  /// An error code that indicates when the user has been disabled
  /// (for example, in the Firebase console).
  static const String userDisabled = 'ERROR_USER_DISABLED';

  /// An error code that indicates when there was too many attempts
  /// to sign in a user.
  static const String tooManyRequests = 'ERROR_TOO_MANY_REQUESTS';

  /// An error code that indicates the Email & Password sign-in method
  /// is not enabled.
  static const String operationNotAllowed = 'ERROR_OPERATION_NOT_ALLOWED';
}
