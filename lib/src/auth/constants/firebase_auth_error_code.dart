/// A class that holds Firebase Authentication error codes.
class FirebaseAuthErrorCode {
  /// An error code that indicates a malformed email address error.
  static const String emailNotFound = 'EMAIL_NOT_FOUND';

  /// An error code that indicates a wrong password error.
  static const String invalidPassword = 'INVALID_PASSWORD';

  /// An error code that indicates when there is no user corresponding
  /// to the given email address, or if the user has been deleted.
  static const String userNotFound = 'USER_NOT_FOUND';

  /// An error code that indicates when the user has been disabled
  /// (for example, in the Firebase console).
  static const String userDisabled = 'USER_DISABLED';

  /// An error code that indicates when there was too many attempts
  /// to sign in a user.
  static const String tooManyAttemptsTryLater = 'TOO_MANY_ATTEMPTS_TRY_LATER';

  /// An error code that indicates the Email & Password sign-in method
  /// is not enabled.
  static const String operationNotAllowed = 'OPERATION_NOT_ALLOWED';

  /// An error code that indicates the provided Firebase API key is not invalid.
  static const String invalidApiKey =
      'API key not valid. Please pass a valid API key.';
}
