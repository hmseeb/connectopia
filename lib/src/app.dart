import 'package:connectopia/src/features/authentication/application/forgot_pwd_bloc/forgot_pwd_bloc.dart';
import 'package:connectopia/src/features/authentication/application/signin_bloc/signin_bloc.dart';
import 'package:connectopia/src/features/authentication/application/signup_bloc/signup_bloc.dart';
import 'package:connectopia/src/features/authentication/data/repository/auth_repo.dart';
import 'package:connectopia/src/common/app/home.dart';
import 'package:connectopia/src/routes.dart';
import 'package:connectopia/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        theme: connectopiaThemeData(context),
        initialRoute: '/',
        home: const HomeScreen(),
        onGenerateRoute: (settings) => GenerateRoutes.onGenerateRoute(settings),
      ),
    );
  }
}
