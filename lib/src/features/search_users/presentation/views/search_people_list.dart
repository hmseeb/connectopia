import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/profile/presentation/screens/user_profile.dart';
import 'package:connectopia/src/features/search_users/application/bloc/search_bloc.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/hint_col.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class PeopleSearchListView extends StatelessWidget {
  const PeopleSearchListView({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    final _height = ScreenSize.height(context);
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is SearchLoading,
          containersColor: Pellet.kDark,
          child: context.read<SearchBloc>().hasFoundUsers
              ? ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount:
                      state is SearchLoadedState ? state.users.length : 10,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    if (state is SearchLoadedState &&
                        id == state.users[index].id) {
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
                        state is SearchLoadedState
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProfileScreen(
                                    user: state.users[index],
                                    posts: state.posts,
                                  ),
                                ),
                              )
                            : null;
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Pellet.kDark,
                        backgroundImage: state is SearchLoadedState &&
                                state.users[index].avatar.isNotEmpty
                            ? MemoryImage(ProfileRepo.decodeBase64(
                                state.users[index].avatar))
                            : Image.asset(Assets.avatarPlaceholder).image,
                      ),
                      title: state is SearchLoadedState
                          ? Text(state.users[index].name.isEmpty
                              ? state.users[index].username
                              : state.users[index].name)
                          : SizedBox(),
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
                  : state is SearchInitial
                      ? HintColumn(
                          text: 'Search for people',
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
      itemBuilder: (context, index) {
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
      },
      itemCount: 10,
      padding: EdgeInsets.symmetric(
        vertical: 16,
      ),
    );
  }
}
