/// Custom exception class to handle various format-related errors.
class AFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Constructs an [AFormatException] with an optional custom error message.
  const AFormatException([
    this.message = 'An unexpected format error occurred. Please check your input.',
  ]);

  /// Creates an [AFormatException] from a specific error message.
  factory AFormatException.fromMessage(String message) {
    return AFormatException(message);
  }

  /// Creates an [AFormatException] from a specific error code.
  factory AFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const AFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const AFormatException('The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const AFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const AFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const AFormatException('The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const AFormatException('The input should be a valid numeric format.');
      default:
        return const AFormatException();
    }
  }

  @override
  String toString() => 'AFormatException: $message';
}
