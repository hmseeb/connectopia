import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/profile/presentation/screens/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconly/iconly.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/messages/error_snackbar.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import '../../../profile/application/personal_profile_bloc/personal_profile_bloc.dart';
import '../../../profile/domain/models/post.dart';

class SinglePostTemplate extends StatefulWidget {
  const SinglePostTemplate({
    super.key,
    required this.post,
    required this.isOwnPost,
    required this.posts,
  });

  final Post post;
  final bool isOwnPost;
  final List<Post> posts;
  @override
  State<SinglePostTemplate> createState() => _SinglePostTemplateState();
}

class _SinglePostTemplateState extends State<SinglePostTemplate> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String baseUrl = dotenv.env['POCKETBASE_URL']! + '/api/files';
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);

    DateTime dateTime = widget.post.created;
    String formattedDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(errorSnack(
            state.error,
          ));
        }
        if (state is ProfilePostDeletedState) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          context.read<ProfileBloc>().add(LoadPersonalProfile());
        }
      },
      builder: (context, state) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: MemoryImage(
                        ProfileRepo.decodeBase64(
                          widget.post.expand.user.avatar,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _width * ScreenSize.kSpaceL,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.isOwnPost
                            ? null
                            : Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return BlocProvider.value(
                                    value: context.read<ProfileBloc>(),
                                    child: UserProfileScreen(
                                      user: widget.post.expand.user,
                                      posts: widget.posts,
                                    ),
                                  );
                                }),
                              );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.expand.user.name,
                            style: TextStyle(
                              fontSize: _width * ScreenSize.kSpaceXL,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              if (widget.post.location.isNotEmpty)
                                Icon(
                                  IconlyLight.location,
                                  color: Pellet.kBlue,
                                  size: _width * ScreenSize.kSpaceL,
                                ),
                              if (widget.post.location.isNotEmpty)
                                Row(
                                  children: [
                                    Text(
                                      " ${widget.post.location}",
                                      style: TextStyle(
                                        color: Pellet.kBlue,
                                        fontSize: _width * ScreenSize.kSpaceL,
                                      ),
                                    ),
                                    Text(' • '),
                                  ],
                                ),
                              Text(
                                "${formattedDate}",
                                style: TextStyle(
                                  color: Pellet.kGrey,
                                  fontSize: _width * ScreenSize.kSpaceL,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // show dropdown menu
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return CupertinoActionSheet(
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      if (widget.isOwnPost) {
                                        context
                                            .read<ProfileBloc>()
                                            .add(LoadPersonalProfile());
                                        context.read<ProfileBloc>().add(
                                              DeletePostButtonPressed(
                                                  widget.post.id,
                                                  widget.post.expand.user),
                                            );
                                      }
                                    },
                                    child: Text(
                                      // TODO: Make sure
                                      widget.isOwnPost ? 'Delete' : 'Report',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {},
                                    child: Text(
                                      'Copy Link',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: widget.post.image.isEmpty
                    ? _height * ScreenSize.kSpaceXS
                    : 0,
              ),
              widget.post.caption.isNotEmpty && widget.post.image.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ReadMoreText(
                        widget.post.caption,
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        style: TextStyle(
                          fontSize: _width * ScreenSize.kSpaceXXL + 2,
                          color: Pellet.kWhite,
                        ),
                        trimCollapsedText: 'read more',
                        trimExpandedText: ' show less',
                        moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Pellet.kBlue),
                        lessStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Pellet.kBlue),
                      ),
                    )
                  : SizedBox(),
              widget.post.image.isNotEmpty
                  ? AspectRatio(
                      aspectRatio: 4 / 5,
                      child: Stack(children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: widget.post.image.length,
                          itemBuilder: (context, index) {
                            return InstaImageViewer(
                              child: CachedNetworkImage(
                                imageUrl:
                                    '$baseUrl/${widget.post.collectionId}/${widget.post.id}/${widget.post.image[index]}',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Lottie.asset(
                                  Assets.progressIndicator,
                                ),
                                height: _height * ScreenSize.kSpaceXXL,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ]),
                    )
                  : SizedBox(),
              SizedBox(
                height: _height * ScreenSize.kSpaceL,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PostBottomIcon(
                      icon: IconlyLight.heart,
                    ),
                    PostBottomIcon(
                      icon: IconlyLight.chat,
                    ),
                    PostBottomIcon(
                      icon: IconlyLight.send,
                    ),
                    Spacer(),
                    widget.post.image.length > 1
                        ? SmoothPageIndicator(
                            controller: _pageController, // PageController
                            count: widget.post.image.length,
                            effect: ScaleEffect(
                              activeDotColor: Pellet.kSecondary,
                              dotWidth: 8,
                              dotHeight: 8,
                            ), // your preferred effect
                            onDotClicked: (index) {
                              _pageController.animateToPage(
                                index,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                          )
                        : SizedBox(),
                    Spacer(),
                    Spacer(),
                    PostBottomIcon(
                      icon: IconlyLight.bookmark,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "${12} likes",
                  style: TextStyle(
                    fontSize: _width * ScreenSize.kSpaceL,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              widget.post.image.isNotEmpty && widget.post.caption.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ReadMoreText(
                        '${widget.post.caption}',
                        trimLines: 1,
                        trimMode: TrimMode.Line,
                        style: TextStyle(
                          fontSize: _width * ScreenSize.kSpaceL,
                        ),
                      ),
                    )
                  : SizedBox(),
              // TODO: Remove divider after implementing list view
              Divider(color: Pellet.kGrey, thickness: 0.1),
            ],
          ),
        );
      },
    );
  }
}

class PostBottomIcon extends StatelessWidget {
  const PostBottomIcon({super.key, required this.icon});

  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    return Row(
      children: [
        Icon(
          icon,
          color: Pellet.kWhite,
          size: _width * ScreenSize.kSpaceXXL,
        ),
        SizedBox(
          width: _width * ScreenSize.kSpaceL,
        ),
      ],
    );
  }
}
