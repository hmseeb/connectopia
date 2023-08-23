import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: _height * 5,
      decoration: BoxDecoration(
          color: Pellet.kDark.withOpacity(
            0.5,
          ),
          borderRadius: BorderRadius.circular(32)),
      child: TextField(
        onTapOutside: ((event) => FocusScope.of(context).unfocus()),
        decoration: InputDecoration(
          hintText: 'Search for people, post, media etc...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
