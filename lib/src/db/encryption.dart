import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Encryption {
  static String encryptAES(String plainText) {
    final key = Key.fromUtf8(dotenv.env['SECRET_ENCRYPTION_KEY']!);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptAES(String encryptedBase64) {
    final key = Key.fromUtf8(dotenv.env['SECRET_ENCRYPTION_KEY']!);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = Encrypted.fromBase64(encryptedBase64);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
