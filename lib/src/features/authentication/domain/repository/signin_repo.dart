import 'package:flutter/material.dart';

class SigninRepository {
  Future<bool> signin(String email, String password) async {
    await Future.delayed(Duration(seconds: 5));
    debugPrint('email: $email, password: $password');
    return true;
  }

  Future<bool> signup(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  Future<bool> signout() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  bool isEmailValid(String email) {
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

    bool hasDigit = false;
    bool hasSpecialChar = false;

    for (var char in password.runes) {
      final charStr = String.fromCharCode(char);

      if (RegExp(r'[0-9]').hasMatch(charStr)) {
        hasDigit = true;
      } else if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(charStr)) {
        hasSpecialChar = true;
      }
    }

    return hasDigit && hasSpecialChar;
  }
}
