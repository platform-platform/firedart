import 'package:firedart/firedart.dart';

/// Represents a [FirebaseAuthException] code.
enum FirebaseAuthExceptionCode {
  /// An exception code indicating that the Firebase API key is not valid.
  invalidApiKey,

  /// An exception code indicating that the user with such email is not found.
  emailNotFound,

  /// An exception code indicating that the password is invalid.
  invalidPassword,

  /// An exception code indicating that the password sign-in option is disabled.
  passwordLoginDisabled,

  /// An exception code indicating that the user has been disabled.
  userDisabled,

  /// An exception code indicating thatthere was too many attempts to sign in a user.
  tooManyAttempts,

  /// An exception code indicating that an unknown error has occurred.
  unknown,
}
