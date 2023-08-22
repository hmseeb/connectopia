import 'package:connectopia/src/features/feeds/presentation/views/single_post.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';

class SinglePostView extends StatelessWidget {
  const SinglePostView({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Pellete.kBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: SinglePostTemplate(
            post: post,
          ),
        ),
      ),
    );
  }
}
