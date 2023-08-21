import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class SinglePostTemplate extends StatefulWidget {
  const SinglePostTemplate({
    super.key,
    required this.username,
    required this.location,
    required this.time,
    this.caption,
    this.images,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
  }) : super();

  final String username;
  final String location;
  final String time;
  final String? caption;
  final List<String>? images;
  final int totalLikes;
  final int totalComments;
  final int totalShares;

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
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    Assets.getRandomAvatar(),
                    height: _height * ScreenSize.kSpaceXL,
                    width: _height * ScreenSize.kSpaceXL,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: _width * ScreenSize.kSpaceL,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                        fontSize: _width * ScreenSize.kSpaceXL,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          IconlyLight.location,
                          color: Pellete.kBlue,
                          size: _width * ScreenSize.kSpaceL,
                        ),
                        Text(
                          " ${widget.location}",
                          style: TextStyle(
                            color: Pellete.kBlue,
                            fontSize: _width * ScreenSize.kSpaceL,
                          ),
                        ),
                        Text(
                          " • ${widget.time}",
                          style: TextStyle(
                            color: Pellete.kGrey,
                            fontSize: _width * ScreenSize.kSpaceL,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert),
              ],
            ),
          ),
          SizedBox(
            height: widget.images == null ? _height * ScreenSize.kSpaceXS : 0,
          ),
          widget.caption != null && widget.images == null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ReadMoreText(
                    widget.caption!,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    style: TextStyle(
                      fontSize: _width * ScreenSize.kSpaceXXL + 2,
                      color: Pellete.kWhite,
                    ),
                    trimCollapsedText: 'read more',
                    trimExpandedText: ' show less',
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Pellete.kBlue),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Pellete.kBlue),
                  ),
                )
              : SizedBox(),

          // TODO: Add images
          widget.images != null
              ? AspectRatio(
                  aspectRatio: 1,
                  child: Stack(children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: widget.images!.length,
                      itemBuilder: (context, index) {
                        return InstaImageViewer(
                          child: Image.network(
                            widget.images![index],
                            height: _height * ScreenSize.kSpaceXXL,
                            width: double.infinity,
                            fit: BoxFit.contain,
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
                widget.images != null && widget.images!.length > 1
                    ? SmoothPageIndicator(
                        controller: _pageController, // PageController
                        count: widget.images!.length,
                        effect: ScaleEffect(
                          activeDotColor: Pellete.kSecondary,
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
              "${widget.totalLikes} likes",
              style: TextStyle(
                fontSize: _width * ScreenSize.kSpaceL,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          widget.images != null && widget.caption != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ReadMoreText(
                    '${widget.caption}',
                    trimLines: 1,
                    trimMode: TrimMode.Line,
                    style: TextStyle(
                      fontSize: _width * ScreenSize.kSpaceL,
                    ),
                  ),
                )
              : SizedBox(),
          // TODO: Remove divider after implementing list view
          Divider(color: Pellete.kGrey, thickness: 0.1),
        ],
      ),
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
          color: Pellete.kWhite,
          size: _width * ScreenSize.kSpaceXXL,
        ),
        SizedBox(
          width: _width * ScreenSize.kSpaceL,
        ),
      ],
    );
  }
}
