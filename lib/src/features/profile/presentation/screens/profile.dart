import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:connectopia/src/common/messages/error_snakbar.dart';
import 'package:connectopia/src/features/profile/application/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
  const UserProfileScreen({super.key, required this.isOwnProfile});
  final bool isOwnProfile;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  late final _userTabController;
  late final _personalTabController;
  @override
  void initState() {
    super.initState();
    _userTabController = TabController(length: 2, vsync: this);
    _personalTabController = TabController(length: 4, vsync: this);
    context.read<ProfileBloc>().add(LoadProfileEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _personalTabController.dispose();
    _userTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(errorSnack(
            state.error,
          ));
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is ProfileLoadingState,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: state is ProfileLoadedState
                    ? PictureBanner(
                        userId: state.user.id,
                        isOwnProfile: widget.isOwnProfile,
                        enableEditMode: false,
                        avatarUrl: state.user.avatar,
                        bannerUrl: state.user.banner,
                      )
                    : SizedBox(
                        height: _height * 20,
                        width: _width,
                      ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: _height * 8),
                    TitleBadge(
                      username: state is ProfileLoadedState
                          ? state.user.name
                          : 'Haseeb Azhar',
                      isVerified: true,
                    ),
                    SizedBox(height: _height * 2),
                    if (state is ProfileLoadedState)
                      if (state.user.bio.isNotEmpty)
                        Bio(
                          state.user.bio,
                        ),
                    SizedBox(height: _height * 2),
                    widget.isOwnProfile
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedProfileButton(
                                  text: 'Edit Profile',
                                  onPressed: () {
                                    if (state is ProfileLoadedState) {
                                      Navigator.pushNamed(
                                        context,
                                        '/edit-profile',
                                        arguments: {
                                          'user': state.user,
                                        },
                                      );
                                    }
                                  }),
                              SizedBox(width: _width * 2),
                              OutlinedProfileButton(
                                  text: 'Share Profile', onPressed: () {}),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ProfileMessageButton(
                                text: 'Message',
                                onPressed: () {},
                              ),
                              SizedBox(width: _width * 2),
                              OutlinedProfileButton(
                                onPressed: () {},
                                text: 'Following',
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
                          title: 'Posts',
                          value: '99',
                        ),
                        InfoColumn(
                          title: 'Followers',
                          value: '1.4M',
                        ),
                        InfoColumn(
                          title: 'Following',
                          value: '6',
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
                        controller: widget.isOwnProfile
                            ? _personalTabController
                            : _userTabController,
                        indicatorColor: Pellete.kWhite,
                        labelColor: Pellete.kWhite,
                        unselectedLabelColor: Pellete.kWhite.withOpacity(0.5),
                        tabs: [
                          Tab(
                            icon: Icon(Icons.grid_on),
                          ),
                          if (widget.isOwnProfile)
                            Tab(
                              icon: Icon(Icons.favorite_border_outlined),
                            ),
                          Tab(
                            icon: Icon(Icons.person_pin_outlined),
                          ),
                          if (widget.isOwnProfile)
                            Tab(
                              icon: Icon(Icons.bookmark_border_outlined),
                            ),
                        ]),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AutoScaleTabBarView(
                  children: [
                    GridPostView(),
                    GridPostView(),
                    if (widget.isOwnProfile) GridPostView(),
                    if (widget.isOwnProfile) GridPostView(),
                  ],
                  controller: widget.isOwnProfile
                      ? _personalTabController
                      : _userTabController,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
