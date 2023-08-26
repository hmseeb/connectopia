import 'dart:async';

import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:flutter/material.dart';
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
    return pocketBase.authStore.isValid;
  }

  void _manageNextScreen() async {
    if (await checkAuth()) {
      final DateTime startTime = DateTime.now(); // Store the start time

      final User user = await _loadUser();
      // final List<Post> posts = await _loadPosts();

      final int loadingTime = DateTime.now().difference(startTime).inSeconds;
      final int remainingTime = loadingTime >= 3 ? 0 : 3 - loadingTime;

      await Future.delayed(
          Duration(seconds: remainingTime)); // Ensure a minimum of 3 seconds

      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {
          'selectedIndex': 0,
          'user': user,
        },
      );
      final int totalLoadingTime =
          DateTime.now().difference(startTime).inMilliseconds;
      print('Total loading time: ${totalLoadingTime}ms');
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/flash');
      });
    }
  }

  Future<User> _loadUser() async {
    ProfileRepo repo = ProfileRepo();
    repo.user;
    User user = User.fromRecord(await repo.user);
    return user;
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
    return Scaffold(
      body: Hero(
        tag: 'logo',
        child: RiveAnimation.asset(
          Assets.splash,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
