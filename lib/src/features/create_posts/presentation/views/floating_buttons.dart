import '../../application/bloc/create_post_bloc.dart';
import '../../../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

Container createPostFloatingActionButton(double _width, BuildContext context) {
  return Container(
    width: _width * 70,
    padding: const EdgeInsets.only(left: 8),
    height: 40,
    decoration: BoxDecoration(
      color: Pellet.kDark.withOpacity(0.5),
      borderRadius: BorderRadius.circular(32),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            context.read<CreatePostBloc>().add(
                  GalleryButtonClickedEvent(),
                );
          },
          icon: Icon(
            IconlyBold.image,
            color: context.read<CreatePostBloc>().pickedFiles.length > 0
                ? Pellet.kSecondary
                : Pellet.kWhite,
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<CreatePostBloc>().add(
                  CameraButtonClickedEvent(),
                );
          },
          icon: Icon(
            IconlyBold.camera,
            color: context.read<CreatePostBloc>().pickedFile != null
                ? Pellet.kSecondary
                : Pellet.kWhite,
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<CreatePostBloc>().add(
                  LocationButtonClickedEvent(),
                );
          },
          icon: Icon(
            context.read<CreatePostBloc>().enableLocation
                ? Icons.location_on
                : Icons.location_off,
            color: context.read<CreatePostBloc>().enableLocation
                ? Pellet.kSecondary
                : Pellet.kWhite,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            context.read<CreatePostBloc>().add(
                  ToggleStoryButtonClickedEvent(),
                );
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Pellet.kDark,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                Text('Story'),
                const SizedBox(width: 8),
                Switch(
                    value: context.read<CreatePostBloc>().enableStory,
                    onChanged: (value) {
                      context.read<CreatePostBloc>().add(
                            ToggleStoryButtonClickedEvent(),
                          );
                    })
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
