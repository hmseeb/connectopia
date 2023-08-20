import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/messages/error_snakbar.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import '../../application/signup_bloc/signup_bloc.dart';
import '../widgets/appbar_title.dart';
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
  late final TextEditingController _usernameController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
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
                      suffixIcon: context.read<SignupBloc>().isValidEmail
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
                        suffixIcon: GestureDetector(
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
                      suffixIcon: context.read<SignupBloc>().isValidUsername
                          ? Icon(Icons.check_box, color: Pellete.kPrimary)
                          : null,
                      hintText: 'Enter your username',
                      controller: _usernameController,
                    );
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
                                      _usernameController.text,
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
                          context.read<SignupBloc>().add(PageChangeEvent());
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
