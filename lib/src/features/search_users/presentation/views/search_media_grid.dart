import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/features/search_users/application/bloc/search_bloc.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/hint_col.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MediaGridView extends StatelessWidget {
  const MediaGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Skeletonizer(
            enabled: state is SearchLoading,
            child: context.read<SearchBloc>().hasFoundMedia
                ? GridView.builder(
                    itemCount:
                        state is SearchLoadedState ? state.posts.length : 20,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/single-post',
                            arguments: {
                              'post': state is SearchLoadedState
                                  ? state.posts[index]
                                  : null,
                              'isOwnPost': false,
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: state is SearchLoadedState
                                  ? NetworkImage(
                                      '${dotenv.env['POCKETBASE_URL']}/api/files/${state.posts[index].collectionId}/${state.posts[index].id}/${state.posts[index].image[0]}/',
                                    )
                                  : Image.asset(Assets.avatarPlaceholder).image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    })
                : state is SearchInitial
                    ? HintColumn(
                        text: 'Search for media',
                        icon: IconlyLight.image_2,
                      )
                    : HintColumn(
                        text: 'No media found',
                        icon: FontAwesomeIcons.solidFaceMeh,
                      ));
      },
    );
  }
}
