import 'package:connectopia/src/features/authentication/presentation/widgets/service_button.dart';
import 'package:flutter/cupertino.dart';
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
    );
  }
}
