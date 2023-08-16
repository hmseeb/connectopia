import 'package:connectopia/src/common/messages/error_snakbar.dart';
import 'package:connectopia/src/features/authentication/application/signin_bloc/signin_bloc.dart';
import 'package:connectopia/src/features/authentication/presentation/widgets/service_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthServiceWrapper extends StatelessWidget {
  const AuthServiceWrapper({
    super.key,
    required double height,
    required double width,
  })  : _height = height,
        _width = width;

  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocConsumer<SigninBloc, SigninState>(
          listener: (context, state) {
            if (state is SigningWithOAuthFailedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(errorSnack(state.error));
            }
          },
          builder: (context, state) {
            return AuthServiceButton(
              height: _height,
              width: _width,
              icon: FontAwesomeIcons.google,
              onClick: () {
                context.read<SigninBloc>().add(SigninWithGoogleButtonPressed());
              },
            );
          },
        ),
        AuthServiceButton(
          height: _height,
          width: _width,
          icon: FontAwesomeIcons.facebookF,
          onClick: () {
            context.read<SigninBloc>().add(SigninWithFacebookButtonPressed());
          },
        ),
      ],
    );
  }
}
