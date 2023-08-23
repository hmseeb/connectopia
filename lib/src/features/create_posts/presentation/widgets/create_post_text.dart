import '../../application/bloc/create_post_bloc.dart';
import '../../../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostTextField extends StatelessWidget {
  const CreatePostTextField({
    super.key,
    required double height,
    required TextEditingController captionController,
  })  : _height = height,
        _captionController = captionController;

  final double _height;
  final TextEditingController _captionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height * 35,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Pellet.kDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        onChanged: (value) {
          context.read<CreatePostBloc>().add(
                CaptionChangedEvent(value),
              );
        },
        keyboardType: TextInputType.multiline,
        controller: _captionController,
        onTapOutside: ((event) => FocusScope.of(context).unfocus()),
        maxLines: 16,
        maxLength: 520,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          hintText: 'What would you like to say?',
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
