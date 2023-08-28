import 'package:connectopia/src/features/search_users/application/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {super.key, required this.controller, required this.onChanged});
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: _height * 5,
      decoration: BoxDecoration(
          color: Pellet.kDark, borderRadius: BorderRadius.circular(32)),
      child: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is UserPostsLoadedState) {
            controller.clear();
          }
        },
        child: TextField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search for people, post, media etc...',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
