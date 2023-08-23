import 'package:connectopia/src/features/profile/presentation/screens/account_settings.dart';
import 'package:flutter/material.dart';

import 'common/app/home.dart';
import 'features/authentication/presentation/screens/access.dart';
import 'features/authentication/presentation/screens/onboarding.dart';
import 'features/authentication/presentation/screens/signin.dart';
import 'features/authentication/presentation/screens/signup.dart';
import 'features/authentication/presentation/screens/splash_screen.dart';
import 'features/create_posts/presentation/screens/create_post.dart';
import 'features/profile/presentation/screens/edit_profile.dart';
import 'features/profile/presentation/screens/profile.dart';
import 'features/profile/presentation/views/single_post_view.dart';

class GenerateRoutes {
  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/flash':
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) =>
              const OnboardScreen(),
          transitionDuration: const Duration(milliseconds: 600),
        );
      case '/access':
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) =>
              const AccessScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case '/signin':
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/animated-signin':
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) =>
              const SigninScreen(),
        );
      case '/animated-signup':
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) =>
              const SignupScreen(),
        );
      case '/home':
        {
          final args = settings.arguments as Map<String, dynamic>;
          return PageRouteBuilder(
            pageBuilder: (_, animation, secondaryAnimation) =>
                HomeScreen(selectedIndex: args['selectedIndex']),
          );
        }

      case '/profile':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => UserProfileScreen(
                  isOwnProfile: args['isOwnProfile'],
                ));
      case '/create-post':
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) => const PostScreen(),
        );
      case '/edit-profile':
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) {
            final args = settings.arguments as Map<String, dynamic>;
            return EditProfileScreen(
              user: args['user'],
            );
          },
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case '/single-post':
        {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
              builder: (_) => SinglePostView(
                    post: args['post'],
                  ));
        }
      case '/account-settings':
        return PageRouteBuilder(
            pageBuilder: (_, animation, secondaryAnimation) {
          final args = settings.arguments as Map<String, dynamic>;
          return AccountSettingsPage(
            username: args['username'],
          );
        });

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
