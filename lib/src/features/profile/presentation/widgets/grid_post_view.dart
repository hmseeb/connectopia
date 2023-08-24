import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/models/post.dart';

class GridPostView extends StatelessWidget {
  const GridPostView({super.key, required this.posts, required this.user});

  final List<Post> posts;
  final User user;

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return Column(
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: posts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            if (posts[index].image.isEmpty)
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/single-post',
                    arguments: {'post': posts[index], 'user': user},
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                      child: Text(
                    posts[index].caption.length > 30
                        ? posts[index].caption.substring(0, 30) + '...'
                        : posts[index].caption,
                    textAlign: TextAlign.center,
                  )),
                ),
              );
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/single-post',
                      arguments: {
                        'post': posts[index],
                        'isOwnPost': true,
                      },
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl:
                        '${dotenv.env['POCKETBASE_URL']}/api/files/${posts[index].collectionId}/${posts[index].id}/${posts[index].image[0]}/',
                    fit: BoxFit.cover,
                    height: _height * 15,
                  ),
                ),
                if (posts[index].image.length > 1)
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 3,
                            left: 3,
                            child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                )),
                          ),
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
              ],
            );
          },
        ),
      ],
    );
  }
}
