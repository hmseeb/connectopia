import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../../../theme/colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText,
    this.avoidBottomInset,
    this.onChanged,
  });

  final bool? obscureText;
  final bool? avoidBottomInset;
  final String hintText;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
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
        onChanged: onChanged,
        scrollPadding: avoidBottomInset ?? false
            ? EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom + 32)
            : EdgeInsets.zero,
        controller: controller,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          fillColor: Pellete.kBlack,
          filled: true,
        ),
      ),
    );
  }
}
