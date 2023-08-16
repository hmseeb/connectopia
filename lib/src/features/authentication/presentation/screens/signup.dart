import 'package:connectopia/src/common/messages/error_snakbar.dart';
import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/authentication/application/signup_bloc/signup_bloc.dart';
import 'package:connectopia/src/features/authentication/presentation/widgets/appbar_title.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../widgets/auth_text_field.dart';
import '../widgets/field_q_button.dart';
import '../widgets/field_title.dart';
import '../widgets/or_divider.dart';
import '../widgets/service_wrapper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool _isPasswordInvisible = true;
  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: Pellete.kBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: AppBarTitle(
            title: 'Sign Up',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(_height * ScreenSize.kSpaceL),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthServiceWrapper(height: _height, width: _width),
                SizedBox(height: _height * 4),
                OrDivider(),
                SizedBox(height: _height * 3),
                TextFieldTitle(title: 'Username'),
                SizedBox(height: _height * 1),
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    return AuthTextField(
                      onChanged: (value) {
                        context
                            .read<SignupBloc>()
                            .add(UsernameChangedEvent(value));
                      },
                      suffixIcon: state is ValidUsernameState
                          ? Icon(Icons.check_box, color: Pellete.kPrimary)
                          : null,
                      hintText: 'Enter your username',
                      controller: _nameController,
                    );
                  },
                ),
                SizedBox(height: _height * 3),
                TextFieldTitle(title: 'Email'),
                SizedBox(height: _height * 1),
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    return AuthTextField(
                      onChanged: (value) {
                        context
                            .read<SignupBloc>()
                            .add(EmailChangedEvent(value));
                      },
                      suffixIcon: state is ValidEmailState
                          ? Icon(Icons.check_box, color: Pellete.kPrimary)
                          : null,
                      hintText: 'Enter your email',
                      controller: _emailController,
                    );
                  },
                ),
                SizedBox(height: _height * 3),
                TextFieldTitle(title: 'Password'),
                SizedBox(height: _height * 1),
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    return AuthTextField(
                        obscureText: _isPasswordInvisible,
                        suffixIcon: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _isPasswordInvisible = !_isPasswordInvisible;
                            });
                          },
                          child: Icon(_isPasswordInvisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: 'Enter your password',
                        controller: _passwordController,
                        onChanged: (value) {
                          context.read<SignupBloc>().add(
                                PasswordChangedEvent(
                                  _passwordController.text,
                                ),
                              );
                        });
                  },
                ),
                SizedBox(height: _height * 6),
                BlocConsumer<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state is SignupFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        errorSnack(state.error),
                      );
                    } else if (state is SignupSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          successSnack('Account created successfully'));
                      //TODO: Navigate to home on successs
                      Navigator.pushReplacementNamed(context, '/signin');
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is ValidState
                          ? () {
                              context.read<SignupBloc>().add(
                                    SignupButtonPressedEvent(
                                      _emailController.text,
                                      _passwordController.text,
                                      _nameController.text,
                                    ),
                                  );
                            }
                          : null,
                      child: state is SignupLoadingState
                          ? Lottie.asset(Assets.progressIndicator)
                          : const Text('Sign Up'),
                    );
                  },
                ),
                SizedBox(height: _height * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldTitle(title: 'Already have an account? '),
                    TextFieldQButton(
                        title: 'Sign in',
                        onTapped: () {
                          Navigator.pushReplacementNamed(
                              context, '/animated-signin');
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
