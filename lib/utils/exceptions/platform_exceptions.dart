/// Exception class for handling various platform-related errors.
class APlatformException implements Exception {
  final String code;

  APlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please verify your email and password.';
      case 'too-many-requests':
        return 'Too many requests have been made. Please try again later.';
      case 'invalid-argument':
        return 'An invalid argument was provided. Please review your input.';
      case 'invalid-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-phone-number':
        return 'The phone number provided is invalid. Please enter a valid phone number.';
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your Firebase project. Please enable it in the Firebase console.';
      case 'session-cookie-expired':
        return 'Your session has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already associated with another account.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your internet connection and try again.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please enter the correct code.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Request quota exceeded. Please wait and try again later.';
      default:
        return 'An unexpected platform error occurred. Please try again later.';
    }
  }
}
