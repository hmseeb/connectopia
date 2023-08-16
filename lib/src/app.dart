import 'package:connectopia/src/features/authentication/application/forgot_pwd_bloc/forgot_pwd_bloc.dart';
import 'package:connectopia/src/features/authentication/application/signin_bloc/signin_bloc.dart';
import 'package:connectopia/src/features/authentication/application/signup_bloc/signup_bloc.dart';
import 'package:connectopia/src/features/authentication/data/repository/auth_repo.dart';
import 'package:connectopia/src/routes.dart';
import 'package:connectopia/src/theme/buttons.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/feeds/presentation/screens/home_screen.dart';

class Connectopia extends StatelessWidget {
  const Connectopia({super.key});

  @override
  Widget build(BuildContext context) {
    AuthRepo authRepo = AuthRepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider<SigninBloc>(create: (context) => SigninBloc(authRepo)),
        BlocProvider<SignupBloc>(create: (context) => SignupBloc(authRepo)),
        BlocProvider<ForgotPwdBloc>(
            create: (context) => ForgotPwdBloc(authRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Connectopia',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
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
        // initialRoute: '/',
        home: const HomeScreen(),
        onGenerateRoute: (settings) => GenerateRoutes.onGenerateRoute(settings),
      ),
    );
  }
}
