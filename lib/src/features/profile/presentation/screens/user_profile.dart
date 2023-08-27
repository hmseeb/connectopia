import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:connectopia/src/features/profile/application/user_profile_bloc/user_profile_bloc.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/hint_col.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import '../widgets/grid_post_view.dart';
import '../widgets/info_col.dart';
import '../widgets/message_button.dart';
import '../widgets/profile_banner.dart';
import '../widgets/profile_button.dart';
import '../widgets/user_bio.dart';
import '../widgets/user_info.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.posts,
    required this.user,
  });
  final List<Post> posts;
  final User user;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  late final _userTabController;
  late bool isFollowing;

  @override
  void initState() {
    super.initState();
    isFollowing = context.read<UserProfileBloc>().isFollowing;
    context.read<UserProfileBloc>().add(LoadUserProfile(widget.user.id));
    _userTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _userTabController.dispose();
  }

  late final User user = widget.user;
  late final List<Post> posts = widget.posts;

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is FollowedSuccessfulState) {
          isFollowing = !isFollowing;
        }

        if (state is UserProfileLoadedState) {
          isFollowing = state.isFollowing!;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
              decoration: BoxDecoration(
                gradient: Pellet.kBackgroundGradient,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: PictureBanner(
                    userId: user.id,
                    isOwnProfile: false,
                    enableEditMode: false,
                    avatarUrl: user.avatar,
                    bannerUrl: user.banner,
                  )),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: _height * 8),
                        TitleBadge(
                          name: user.name,
                          username: user.username,
                          isVerified: user.verified,
                        ),
                        SizedBox(height: _height * 2),
                        if (user.bio.isNotEmpty)
                          Bio(
                            user.bio,
                          ),
                        SizedBox(height: _height * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProfileMessageButton(
                              text: 'Message',
                              onPressed: () {},
                            ),
                            SizedBox(width: _width * 2),
                            OutlinedProfileButton(
                              backgroundColor:
                                  isFollowing ? null : Pellet.kBlue,
                              showOutline: isFollowing ? true : false,
                              onPressed: () {
                                if (isFollowing) {
                                  context
                                      .read<UserProfileBloc>()
                                      .add(UnfollowButtonPressed(user.id));
                                } else {
                                  context
                                      .read<UserProfileBloc>()
                                      .add(FollowButtonPressed(user.id));
                                }
                              },
                              text: state is FollowingLoadingState
                                  ? 'Updating...'
                                  : isFollowing
                                      ? 'Following'
                                      : 'Follow',
                            ),
                            SizedBox(width: _width * 2),
                            Icon(Icons.more_vert_outlined),
                          ],
                        ),
                        SizedBox(height: _height * 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InfoColumn(
                                title: 'Posts', value: posts.length.toString()),
                            InfoColumn(
                              title: 'Followers',
                              value: '1.4M',
                            ),
                            InfoColumn(
                              title: 'Following',
                              value: '2.6K',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 1,
                    toolbarHeight: 0,
                    floating: true,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(_height * 6),
                      child: Container(
                        child: TabBar(
                            controller: _userTabController,
                            indicatorColor: Pellet.kWhite,
                            labelColor: Pellet.kWhite,
                            unselectedLabelColor:
                                Pellet.kWhite.withOpacity(0.5),
                            tabs: [
                              Tab(icon: Icon(Icons.grid_on)),
                              Tab(icon: Icon(Icons.person_pin_outlined)),
                            ]),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AutoScaleTabBarView(
                      children: [
                        Column(
                          children: [
                            ...[
                              if (posts.isNotEmpty) ...[
                                GridPostView(
                                  posts: posts,
                                  user: user,
                                ),
                                SizedBox(
                                  height: _height * 12,
                                ),
                              ] else
                                SizedBox(
                                  height: _height * 20,
                                  child: HintColumn(
                                      text: 'No Posts Yet',
                                      icon: IconlyLight.camera),
                                )
                            ],
                          ],
                        ),
                        SizedBox(),
                      ],
                      controller: _userTabController,
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
