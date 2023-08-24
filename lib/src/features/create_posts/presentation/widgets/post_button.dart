import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/colors.dart';
import '../../application/bloc/create_post_bloc.dart';

class PostButton extends StatelessWidget {
  const PostButton({
    super.key,
    required TextEditingController captionController,
    required bool toggleStory,
    required bool enableLocation,
    required this.state,
  })  : _captionController = captionController,
        _toggleStory = toggleStory,
        _enableLocation = enableLocation;

  final TextEditingController _captionController;
  final bool _toggleStory;
  final bool _enableLocation;
  final CreatePostState state;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      onPressed: () {
        if (state is PickedImageFromGallery ||
            state is CapturedPhoto ||
            state is ValidSubmitState)
          context.read<CreatePostBloc>().add(
                CreatePostButtonClickedEvent(
                  caption: _captionController.text,
                  toggleStory: _toggleStory,
                  enableLocation: _enableLocation,
                ),
              );
      },
      child: Text(
        'POST',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      color: state is PickedImageFromGallery ||
              state is CapturedPhoto ||
              state is ValidSubmitState
          ? Pellet.kSecondary
          : Pellet.kGrey,
    );
  }
}
