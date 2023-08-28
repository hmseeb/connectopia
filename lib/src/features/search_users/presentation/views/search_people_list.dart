import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:connectopia/src/features/profile/presentation/screens/user_profile.dart';
import 'package:connectopia/src/features/search_users/application/bloc/search_bloc.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/hint_col.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class PeopleSearchListView extends StatefulWidget {
  const PeopleSearchListView({super.key, required this.id});
  final String id;

  @override
  State<PeopleSearchListView> createState() => _PeopleSearchListViewState();
}

late List<Post> media;
late List<User> users;

class _PeopleSearchListViewState extends State<PeopleSearchListView> {
  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    final _height = ScreenSize.height(context);
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is UserPostsLoadedState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfileScreen(
                user: users[state.index],
                posts: state.posts,
              ),
            ),
          );
        } else if (state is SearchLoadedState) {
          media = state.media;
          users = state.users;
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is SearchLoading,
          containersColor: Pellet.kDark,
          child: state is SearchLoadedState
              ? ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: state.users.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    if (widget.id == state.users[index].id) {
                      return SizedBox(
                        height: _height * 70,
                        child: HintColumn(
                          text: 'No users found',
                          icon: FontAwesomeIcons.faceMehBlank,
                        ),
                      );
                    }
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      onTap: () {
                        context
                            .read<SearchBloc>()
                            .add(GetUserPosts(users[index].id, index));
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Pellet.kDark,
                        backgroundImage: users[index].avatar.isNotEmpty
                            ? MemoryImage(
                                ProfileRepo.decodeBase64(users[index].avatar))
                            : Image.asset(Assets.avatarPlaceholder).image,
                      ),
                      title: Text(users[index].name.isEmpty
                          ? users[index].username
                          : users[index].name),
                      trailing: Container(
                        width: _width * 25,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          gradient: Pellet.kFlashBackgroundGradient,
                        ),
                        child: Text(
                          'View',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : state is SearchLoading
                  ? FakeListView()
                  : state is LoadingUserPosts
                      ? Lottie.asset(Assets.progressIndicator)
                      : state is SearchInitial || state is UserPostsLoadedState
                          ? HintColumn(
                              text: 'Search for People',
                              icon: IconlyLight.user_1,
                            )
                          : HintColumn(
                              text: 'No users found',
                              icon: FontAwesomeIcons.faceMehBlank,
                            ),
        );
      },
    );
  }
}

class FakeListView extends StatelessWidget {
  const FakeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: ((context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Pellet.kDark,
          ),
          title: Text('Haseeb Azhar'),
          trailing: Text(
            'View',
          ),
        );
      }),
    );
  }
}
