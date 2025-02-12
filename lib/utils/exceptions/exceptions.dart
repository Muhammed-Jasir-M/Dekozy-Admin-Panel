/// Exception class for handling various errors.
class AExceptions implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const AExceptions([
    this.message = 'An unexpected error occurred. Please try again.',
  ]);

  /// Create an authentication exception from a Firebase authentication exception code.
  factory AExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const AExceptions('The email address is already registered. Please use a different email.');
      case 'invalid-email':
        return const AExceptions('The email address provided is invalid. Please enter a valid email.');
      case 'weak-password':
        return const AExceptions('The password is too weak. Please choose a stronger password.');
      case 'user-disabled':
        return const AExceptions('This user account has been disabled. Please contact support for assistance.');
      case 'user-not-found':
        return const AExceptions('No user found for the provided credentials.');
      case 'wrong-password':
        return const AExceptions('Incorrect password. Please check your password and try again.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const AExceptions('The login credentials are invalid. Please verify your information.');
      case 'too-many-requests':
        return const AExceptions('Too many requests have been made. Please try again later.');
      case 'invalid-argument':
        return const AExceptions('An invalid argument was provided. Please review your input and try again.');
      case 'invalid-password':
        return const AExceptions('Incorrect password. Please try again.');
      case 'invalid-phone-number':
        return const AExceptions('The phone number you entered is invalid. Please enter a valid phone number.');
      case 'operation-not-allowed':
        return const AExceptions('This sign-in method is not enabled for your Firebase project. Please enable it in the Firebase console.');
      case 'session-cookie-expired':
        return const AExceptions('Your session has expired. Please sign in again.');
      case 'uid-already-exists':
        return const AExceptions('The provided user ID is already associated with another account.');
      case 'sign_in_failed':
        return const AExceptions('Sign-in failed. Please try again.');
      case 'network-request-failed':
        return const AExceptions('A network error occurred. Please check your internet connection and try again.');
      case 'internal-error':
        return const AExceptions('An internal error occurred. Please try again later.');
      case 'invalid-verification-code':
        return const AExceptions('The verification code is invalid. Please enter the correct code.');
      case 'invalid-verification-id':
        return const AExceptions('The verification ID is invalid. Please request a new verification code.');
      case 'quota-exceeded':
        return const AExceptions('Request quota exceeded. Please wait and try again later.');
      default:
        return const AExceptions();
    }
  }
}
