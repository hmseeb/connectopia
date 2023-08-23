import 'package:flutter/material.dart';

import '../../../../common/app/logo.dart';
import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import '../widgets/animated_flash_title.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int _opacity = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = ScreenSize.height(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: Pellete.kFlashBackgroundGradient,
      ),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(height * ScreenSize.kSpaceL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Hero(
                tag: 'logo',
                child: SizedBox(
                  width: 240,
                  height: 240,
                  child: AppLogo(),
                ),
              ),
              AnimatedFlashTitle(title: 'Connectopia', opacity: _opacity),
              SizedBox(height: height * 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Pellete.kWhite),
                  foregroundColor: MaterialStateProperty.all(Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/access');
                },
                child: const Text('GET STARTED'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
