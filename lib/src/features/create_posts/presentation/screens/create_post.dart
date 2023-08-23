import '../../../../common/messages/error_snakbar.dart';
import '../../../../constants/assets.dart';
import '../../application/bloc/create_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

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

  bool _toggleStory = false;
  bool _enableLocation = false;

  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return BlocConsumer<CreatePostBloc, CreatePosttate>(
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
                  gradient: Pellete.kBackgroundGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 48,
                      ),
                      Row(
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
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            onPressed: () {
                              if (state is PickedImageFromGallery ||
                                  state is CapturedPhoto ||
                                  state is ValidCaptionState)
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
                                    state is ValidCaptionState
                                ? Pellete.kSecondary
                                : Pellete.kGrey,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: _height * 35,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Pellete.kDark,
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
                          onTapOutside: ((event) =>
                              FocusScope.of(context).unfocus()),
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
                      ),
                    ],
                  ),
                ),
              ),
              if (state is CreatingPost)
                Center(child: Lottie.asset(Assets.progressIndicator)),
            ],
          ),
          floatingActionButton: Container(
            width: _width * 70,
            padding: const EdgeInsets.only(left: 8),
            height: 40,
            decoration: BoxDecoration(
              color: Pellete.kDark.withOpacity(0.5),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CreatePostBloc>().add(
                          GallaryButtonClickedEvent(),
                        );
                  },
                  icon: Icon(
                    IconlyBold.image,
                    color: state is PickedImageFromGallery
                        ? Pellete.kSecondary
                        : Pellete.kWhite,
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
                    color: state is CapturedPhoto
                        ? Pellete.kSecondary
                        : Pellete.kWhite,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CreatePostBloc>().add(
                          LocationButtonClickedEvent(),
                        );
                    setState(() {
                      _enableLocation = !_enableLocation;
                    });
                  },
                  icon: Icon(
                    _enableLocation ? Icons.location_on : Icons.location_off,
                    color:
                        _enableLocation ? Pellete.kSecondary : Pellete.kWhite,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _toggleStory = !_toggleStory;
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Pellete.kDark,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 8),
                        Text('Story'),
                        const SizedBox(width: 8),
                        Switch(
                            value: _toggleStory,
                            onChanged: (value) {
                              setState(() {
                                _toggleStory = value;
                              });
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        );
      },
    );
  }
}
