import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:connectopia/src/features/profile/application/personal_profile_bloc/personal_profile_bloc.dart';
import 'package:connectopia/src/features/profile/presentation/widgets/fake_grid_view.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/hint_col.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import '../widgets/grid_post_view.dart';
import '../widgets/info_col.dart';
import '../widgets/profile_banner.dart';
import '../widgets/profile_button.dart';
import '../widgets/settings_icon.dart';
import '../widgets/user_bio.dart';
import '../widgets/user_info.dart';

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({
    super.key,
  });

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen>
    with TickerProviderStateMixin {
  late final _personalTabController;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadPersonalProfile());
    _personalTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _personalTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: Pellet.kBackgroundGradient,
          ),
          child: Skeletonizer(
            enabled: state is ProfileLoadingState,
            child: CustomRefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(LoadPersonalProfile());
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: PictureBanner(
                    userId: state is ProfileLoadedState ? state.user.id : '',
                    isOwnProfile: true,
                    enableEditMode: false,
                    avatarUrl:
                        state is ProfileLoadedState ? state.user.avatar : '',
                    bannerUrl:
                        state is ProfileLoadedState ? state.user.banner : '',
                  )),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: _height * 8),
                        TitleBadge(
                          name: state is ProfileLoadedState
                              ? state.user.name
                              : 'John Doe',
                          username: state is ProfileLoadedState
                              ? state.user.username
                              : 'john',
                          isVerified: state is ProfileLoadedState
                              ? state.user.verified
                              : false,
                        ),
                        SizedBox(height: _height * 2),
                        if (state is ProfileLoadedState)
                          if (state.user.bio.isNotEmpty)
                            Bio(
                              state.user.bio,
                            ),
                        SizedBox(height: _height * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedProfileButton(
                              showOutline:
                                  state is ProfileLoadedState ? true : false,
                              text: 'Edit Profile',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/edit-profile',
                                  arguments: {
                                    'user': state is ProfileLoadedState
                                        ? state.user
                                        : null
                                  },
                                );
                              },
                            ),
                            SizedBox(width: _width * 2),
                            SettingsIconButton(
                              emailVisibility: state is ProfileLoadedState
                                  ? state.user.emailVisibility
                                      ? true
                                      : false
                                  : false,
                              name: state is ProfileLoadedState
                                  ? state.user.name
                                  : 'John Doe',
                              username: state is ProfileLoadedState
                                  ? state.user.username
                                  : 'john',
                            ),
                          ],
                        ),
                        SizedBox(height: _height * 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InfoColumn(
                                title: 'Posts',
                                value: state is ProfileLoadedState
                                    ? state.posts.length.toString()
                                    : '99'),
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
                            controller: _personalTabController,
                            indicatorColor: Pellet.kWhite,
                            labelColor: Pellet.kWhite,
                            unselectedLabelColor:
                                Pellet.kWhite.withOpacity(0.5),
                            tabs: [
                              Tab(icon: Icon(Icons.grid_on)),
                              Tab(icon: Icon(Icons.favorite_border_outlined)),
                              Tab(icon: Icon(Icons.person_pin_outlined)),
                              Tab(icon: Icon(Icons.bookmark_border_outlined)),
                            ]),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AutoScaleTabBarView(
                      children: [
                        Column(
                          children: [
                            if (state is ProfileLoadedState) ...[
                              if (state.posts.isNotEmpty) ...[
                                GridPostView(
                                  posts: state.posts,
                                  user: state.user,
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
                            ] else
                              FakeGridView(),
                          ],
                        ),
                        SizedBox(),
                        SizedBox(),
                        SizedBox(),
                      ],
                      controller: _personalTabController,
                    ),
                  ),
                ],
              ),
              builder: MaterialIndicatorDelegate(
                builder: (context, controller) {
                  return Lottie.asset(Assets.progressIndicator);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
