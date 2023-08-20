import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../../../theme/colors.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText,
    this.avoidBottomInset,
    this.onChanged,
    this.suffixIcon,
  });

  final bool? obscureText;
  final bool? avoidBottomInset;
  final String hintText;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final Widget? suffixIcon;
  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: const GradientBoxBorder(
          gradient: LinearGradient(colors: [
            Pellete.kPrimary,
            Pellete.kSecondary,
          ]),
          width: 2,
        ),
      ),
      child: TextFormField(
        obscureText: widget.obscureText ?? false,
        onChanged: widget.onChanged,
        scrollPadding: widget.avoidBottomInset ?? false
            ? EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom + 32)
            : EdgeInsets.zero,
        controller: widget.controller,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          suffixIconColor: Pellete.kSecondary,
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          fillColor: Pellete.kDark,
          filled: true,
        ),
      ),
    );
  }
}
