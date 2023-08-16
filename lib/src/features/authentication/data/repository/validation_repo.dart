import 'package:logger/logger.dart';

class ValidationRepo {
  Logger logger = Logger();
  bool isValidEmail(String email) {
    // Basic email format validation
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (!emailRegex.hasMatch(email)) {
      return false; // Invalid format
    }

    // Discourage Gmail dot trick
    final normalizedEmail = email.replaceAll('.', '');
    if (normalizedEmail.contains('@gmail.com')) {
      return false; // Invalid email due to dot trick
    }

    // Discourage Gmail plus trick
    final parts = email.split('@');
    if (parts.length == 2 && parts[1] == 'gmail.com') {
      final localPart = parts[0].split('+')[0];
      final normalizedLocalPart = localPart.replaceAll('.', '');
      if (normalizedLocalPart.isEmpty) {
        return false; // Invalid email due to plus trick
      }
    }

    // TODO: Add more temporary email domains
    final tempEmailDomains = [
      'tempmail.com',
      'example.com',
      // Add more temporary domains here
    ];

    if (tempEmailDomains.any((domain) => email.endsWith(domain))) {
      return false; // Invalid email due to temporary domain
    }

    return true; // Email is valid
  }

  bool isValidPassword(String password) {
    if (password.length < 8) {
      return false; // Password length is less than 8 characters
    }
    return true;
  }

  bool isValidUsername(String username) {
    // Regular expression to match valid usernames.
    // This regex allows usernames with only lowercase letters, numbers, and underscores.
    username.replaceAll(' ', '');

    if (username.length < 4) return false;
    final RegExp usernameRegex = RegExp(r'^[a-z0-9_]+$');

    return usernameRegex.hasMatch(username);
  }
}
