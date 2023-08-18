import 'package:connectopia/src/common/splash/splash_screen.dart';
import 'package:connectopia/src/features/authentication/presentation/screens/access.dart';
import 'package:connectopia/src/features/authentication/presentation/screens/onboarding.dart';
import 'package:connectopia/src/features/authentication/presentation/screens/signin.dart';
import 'package:connectopia/src/features/authentication/presentation/screens/signup.dart';
import 'package:connectopia/src/common/app/home.dart';
import 'package:connectopia/src/features/profile/presentation/screens/profile.dart';
import 'package:flutter/material.dart';

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
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) => const HomeScreen(),
        );
      case '/profile':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => UserProfileScreen(
                  isOwnProfile: args['isOwnProfile'],
                ));

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
