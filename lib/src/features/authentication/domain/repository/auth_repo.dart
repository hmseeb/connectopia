import 'package:connectopia/src/db/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

PocketBase pb = PocketBaseSingleton().pb;

class AuthRepo {
  Future<Object> signin(String email, String password) async {
    try {
      final user =
          await pb.collection('users').authWithPassword(email, password);
      return user;
    } catch (error) {
      throw error;
    }
  }

  Future<Object> signup(String email, String password, String name) async {
    try {
      final user = await pb.collection('users').create(body: {
        'email': email,
        'password': password,
        'passwordConfirm': password,
        'username': name,
      });
      return user;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> signout() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

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

  String handleError(Object? error) {
    String errorMsg = error.toString();

    if (errorMsg.contains('validation_invalid_email')) {
      return 'Email invalid or already taken';
    } else if (errorMsg.contains('validation_invalid_username')) {
      return 'Username invalid or already taken';
    }
    return 'An error occurred.';
  }
}
