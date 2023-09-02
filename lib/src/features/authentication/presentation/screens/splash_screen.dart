import 'dart:async';

import 'package:connectopia/src/features/feeds/application/bloc/feeds_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rive/rive.dart';

import '../../../../constants/assets.dart';
import '../../../../db/pocketbase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _manageNextScreen();
    super.initState();
  }

  Future<bool> checkAuth() async {
    PocketBase pocketBase = await PocketBaseSingleton.instance;
    pocketBase.authStore.clear();
    return pocketBase.authStore.isValid;
  }

  void _manageNextScreen() async {
    if (await checkAuth()) {
      context.read<FeedsBloc>().add(ValidUserAuthEvent());
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/flash');
      });
    }
  }

  // Future<List<Post>> _loadPosts() async {
  //   ProfileRepo repo = ProfileRepo();
  //   repo.post;
  //   List<Post> posts =
  //       (await repo.post).map((post) => Post.fromRecord(post)).toList();
  //   return posts;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedsBloc, FeedsState>(
      listener: (context, state) {
        if (state is FeedsLoadedState) {
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {
              'selectedIndex': 0,
              'user': state.user,
              'posts': state.posts
            },
          );
        }
      },
      child: Scaffold(
        body: Hero(
          tag: 'logo',
          child: RiveAnimation.asset(
            Assets.splash,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
