import '../views/floating_buttons.dart';
import '../widgets/create_post_appbar.dart';
import '../widgets/create_post_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/messages/error_snackbar.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import '../../application/bloc/create_post_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late final TextEditingController _captionController;
  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return BlocConsumer<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        if (state is PostCreationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(errorSnack(
            state.error,
          ));
        } else if (state is CreatedPost) {
          Navigator.pop(context);
        }

        if (state is PickedImageFromGallery) {
          ScaffoldMessenger.of(context).showSnackBar(
            successSnack(
              'Selected ${state.pickedFile.length} images from gallery',
            ),
          );
        } else if (state is CapturedPhoto) {
          ScaffoldMessenger.of(context).showSnackBar(
            successSnack(
              'Photo captured',
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: Pellet.kBackgroundGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 48,
                      ),
                      CreatePostAppBar(
                          captionController: _captionController, state: state),
                      const SizedBox(
                        height: 16,
                      ),
                      CreatePostTextField(
                          height: _height,
                          captionController: _captionController),
                    ],
                  ),
                ),
              ),
              if (state is CreatingPost)
                Center(child: Lottie.asset(Assets.progressIndicator)),
            ],
          ),
          floatingActionButton: createPostFloatingActionButton(_width, context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        );
      },
    );
  }
}
