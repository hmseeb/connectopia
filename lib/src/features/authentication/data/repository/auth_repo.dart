import 'package:connectopia/src/db/pocketbase.dart';
import 'package:logger/logger.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthRepo {
  PocketBase pb = PocketBaseSingleton().pb;
  AuthRepo();
  Logger logger = Logger();

  Future<Object> signin(String email, String password) async {
    try {
      RecordAuth user =
          await pb.collection('users').authWithPassword(email, password);
      return user;
    } catch (error) {
      throw error;
    }
  }

  Future<Object> signup(String email, String password, String name) async {
    try {
      RecordModel user = await pb.collection('users').create(body: {
        'email': email,
        'password': password,
        'passwordConfirm': password,
        'username': name,
      });
      return user;
    } catch (error) {
      logger.e(error);
      throw error;
    }
  }

  Future sendVerificationEmail(String email) async {
    try {
      await pb.collection('users').requestPasswordReset(email);
    } catch (error) {
      logger.e(error);
      throw error;
    }
  }

  // TODO: Fix not working on real device
  Future signinWithOAuth(String provider) async {
    try {
      RecordAuth user = await pb.collection('users').authWithOAuth2(
        provider,
        (Uri) {
          launchUrl(
            Uri,
            mode: LaunchMode.inAppWebView,
          );
        },
      );
      return user;
    } catch (error) {
      logger.e(error);
      throw error;
    }
  }

  Future<bool> signout() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
