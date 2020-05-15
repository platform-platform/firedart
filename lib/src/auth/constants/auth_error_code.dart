/// A class containing codes of authentication errors.
class AuthErrorCode {
  /// Indicates malformed email address error.
  static const String invalidEmail = 'ERROR_INVALID_EMAIL';

  /// Indicates wrong password error.
  static const String wrongPasswrod = 'ERROR_WRONG_PASSWORD';

  /// Indicates an error when there is no user corresponding to the given
  /// email address, or if the user has been deleted.
  static const String userNotFound = 'ERROR_USER_NOT_FOUND';

  /// Indicates an error when the user has been disabled
  /// (for example, in the Firebase console).
  static const String userDisabled = 'ERROR_USER_DISABLED';

  /// Indicates an error when there was too many attempts to sign in a user.
  static const String tooManyRequests = 'ERROR_TOO_MANY_REQUESTS';

  /// Indicates that Email & Password accounts are not enabled.
  static const String operationNotAllowed = 'ERROR_OPERATION_NOT_ALLOWED';
}
