import 'package:connectopia/src/routes.dart';
import 'package:connectopia/src/theme/buttons.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';

class Connectopia extends StatelessWidget {
  const Connectopia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connectopia',
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Pellete.kWhite,
              displayColor: Pellete.kWhite,
            ),
        scaffoldBackgroundColor: Colors.transparent,
        elevatedButtonTheme: CustomElevetedButton.elevetedButtonThemeData(),
        fontFamily: 'Heebo',
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Pellete.kPrimary,
          secondary: Pellete.kSecondary,
        ),
      ),
      initialRoute: '/',
      // home: const SigninScreen(),
      onGenerateRoute: (settings) => GenerateRoutes.onGenerateRoute(settings),
    );
  }
}
