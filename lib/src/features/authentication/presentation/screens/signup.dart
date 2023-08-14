import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/authentication/presentation/widgets/appbar_title.dart';
import 'package:connectopia/src/features/authentication/presentation/widgets/service_button.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/auth_text_field.dart';
import '../widgets/field_q_button.dart';
import '../widgets/field_title.dart';
import '../widgets/or_divider.dart';

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

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.pop(context);
        }
      },
      child: Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuthServiceButton(
                        height: _height,
                        width: _width,
                        icon: FontAwesomeIcons.google,
                      ),
                      AuthServiceButton(
                        height: _height,
                        width: _width,
                        icon: FontAwesomeIcons.instagram,
                      ),
                    ],
                  ),
                  SizedBox(height: _height * 4),
                  OrDivider(),
                  SizedBox(height: _height * 3),
                  TextFieldTitle(title: 'Name'),
                  SizedBox(height: _height * 1),
                  AuthTextField(
                    hintText: 'Enter your name',
                    controller: _nameController,
                  ),
                  SizedBox(height: _height * 3),
                  TextFieldTitle(title: 'Email'),
                  SizedBox(height: _height * 1),
                  AuthTextField(
                    hintText: 'Enter your email',
                    controller: _emailController,
                  ),
                  SizedBox(height: _height * 3),
                  TextFieldTitle(title: 'Password'),
                  SizedBox(height: _height * 1),
                  AuthTextField(
                    avoidBottomInset: true,
                    hintText: 'Enter your password',
                    controller: _passwordController,
                  ),
                  SizedBox(height: _height * 6),
                  ElevatedButton(onPressed: () {}, child: Text('Sign Up')),
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
      ),
    );
  }
}
