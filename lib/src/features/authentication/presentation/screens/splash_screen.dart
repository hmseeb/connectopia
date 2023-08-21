import 'dart:async';

import 'package:connectopia/src/db/pocketbase.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rive/rive.dart';

import '../../../../constants/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      PocketBase pocketBase = await _initPocketBase();
      if (pocketBase.authStore.isValid)
        Navigator.pushReplacementNamed(context, '/home');
      else
        Navigator.pushReplacementNamed(context, '/flash');
    });
    super.initState();
  }

  Future<PocketBase> _initPocketBase() async {
    PocketBase pocketBase = await PocketBaseSingleton.instance;
    return pocketBase;
  }

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
