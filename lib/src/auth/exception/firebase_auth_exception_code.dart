import 'package:firedart/firedart.dart';

/// Represents a [FirebaseAuthException] code.
enum FirebaseAuthExceptionCode {
  /// Indicates whether the Firebase API key is not valid.
  invalidApiKey,

  /// Indicates whether the user with such email is not found.
  emailNotFound,

  /// Indicates whether the password is invalid.
  invalidPassword,

  /// Indicates whether the password sign-in option is disabled.
  passwordLoginDisabled,

  /// Indicates whether the user has been disabled.
  userDisabled,

  /// Indicates whether there was too many attempts to sign in a user.
  tooManyAttempts,

  /// Indicates whether an unknown error has occurred.
  unknown,
}
