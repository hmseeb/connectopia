import 'package:connectopia/src/features/search_users/application/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/application/forgot_pwd_bloc/forgot_pwd_bloc.dart';
import 'features/authentication/application/signin_bloc/signin_bloc.dart';
import 'features/authentication/application/signup_bloc/signup_bloc.dart';
import 'features/authentication/data/repository/auth_repo.dart';
import 'features/create_posts/application/bloc/create_post_bloc.dart';
import 'features/profile/application/edit_profile_bloc/edit_profile_bloc.dart';
import 'features/profile/application/personal_profile_bloc/personal_profile_bloc.dart';
import 'features/profile/application/profile_settings/profile_settings_bloc.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

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
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
        BlocProvider<EditProfileBloc>(create: (context) => EditProfileBloc()),
        BlocProvider<CreatePostBloc>(create: (context) => CreatePostBloc()),
        BlocProvider<AccountSettings>(create: (context) => AccountSettings()),
        BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Connectopia',
        theme: connectopiaThemeData(context),
        initialRoute: '/',
        onGenerateRoute: (settings) => GenerateRoutes.onGenerateRoute(settings),
      ),
    );
  }
}
