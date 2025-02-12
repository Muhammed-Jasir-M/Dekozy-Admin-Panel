/// Custom exception class to handle various Firebase-related errors.
class AFirebaseException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  AFirebaseException(this.code);

  /// Returns the user-friendly error message based on the error code.
  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token is improperly formatted. Please verify your custom token.';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found for the given email or UID.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'provider-already-linked':
        return 'This account is already linked with another provider.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support for assistance.';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please request a new verification code.';
      case 'captcha-check-failed':
        return 'reCAPTCHA verification failed. Please try again.';
      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication with the provided API key.';
      case 'keychain-error':
        return 'A keychain error occurred. Please check your keychain and try again.';
      case 'internal-error':
        return 'An internal authentication error occurred. Please try again later.';
      case 'invalid-app-credential':
        return 'The app credential is invalid. Please provide a valid credential.';
      case 'user-mismatch':
        return 'The supplied credentials do not match the previously signed-in user.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please sign in again.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'account-exists-with-different-credential':
        return 'An account with the same email exists but with different sign-in credentials.';
      case 'missing-iframe-start':
        return 'The email template is missing the iframe start tag.';
      case 'missing-iframe-end':
        return 'The email template is missing the iframe end tag.';
      case 'missing-iframe-src':
        return 'The email template is missing the iframe src attribute.';
      case 'auth-domain-config-required':
        return 'The authDomain configuration is required for the action code verification link.';
      case 'missing-app-credential':
        return 'The app credential is missing. Please provide valid credentials.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'web-storage-unsupported':
        return 'Web storage is not supported or is disabled.';
      case 'app-deleted':
        return 'This instance of FirebaseApp has been deleted.';
      case 'user-token-mismatch':
        return 'The provided user token does not match the authenticated user’s ID.';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender’s email.';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please provide a valid email.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user token has expired. Please sign in again.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check and try again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with another user account.';
      default:
        return 'An unexpected Firebase error occurred. Please try again.';
    }
  }

  @override
  String toString() => 'AFirebaseException($code): $message';
}
