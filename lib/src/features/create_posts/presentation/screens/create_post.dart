import 'package:connectopia/src/features/create_posts/application/bloc/create_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
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
  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return BlocConsumer<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
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
                        onPressed: () {},
                        child: Text(
                          'POST',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Colors.blue,
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
                    color: Pellete.kWhite,
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
                    color: Pellete.kWhite,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CreatePostBloc>().add(
                          LocationButtonClickedEvent(),
                        );
                  },
                  icon: Icon(
                    IconlyBold.location,
                    color: Pellete.kWhite,
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
