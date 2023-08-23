import '../../application/bloc/create_post_bloc.dart';
import 'post_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostAppBar extends StatelessWidget {
  const CreatePostAppBar({
    super.key,
    required TextEditingController captionController,
    required this.state,
  }) : _captionController = captionController;

  final TextEditingController _captionController;
  final CreatePostState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Text(
          'Create',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        PostButton(
          captionController: _captionController,
          toggleStory: context.read<CreatePostBloc>().enableStory,
          enableLocation: context.read<CreatePostBloc>().enableLocation,
          state: state,
        ),
      ],
    );
  }
}
