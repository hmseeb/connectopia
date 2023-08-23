import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    super.key,
    required this.hintText,
    this.isBio = false,
    required this.controller,
    required this.onChanged,
  });

  final String hintText;
  final bool isBio;
  final TextEditingController controller;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _width * 5,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Pellet.kDark,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTapOutside: ((event) => FocusScope.of(context).unfocus()),
        maxLines: isBio ? 3 : 1,
        maxLength: isBio ? 420 : null,
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
