import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/profile/presentation/widgets/profile_button.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class PictureBanner extends StatelessWidget {
  const PictureBanner({
    super.key,
    required this.isOwnProfile,
    required this.enableEditMode,
  });

  final bool isOwnProfile;
  final bool enableEditMode;

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Opacity(
          opacity: enableEditMode ? 0.5 : 1,
          child: AspectRatio(
            aspectRatio: 2,
            child: InstaImageViewer(
              child: Image.network(
                Assets.randomImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        if (enableEditMode)
          Positioned(
              top: _height * 10,
              left: _width * 25,
              child: EditBannerButton(
                text: 'UPDATE COVER PHOTO',
                onPressed: () {},
              )),
        if (enableEditMode)
          Positioned(
              top: _height * 4,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios))),
        Positioned(
          bottom: _height * -5,
          left: _width * 40,
          child: SizedBox(
            height: _height * 10,
            width: _height * 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: InstaImageViewer(
                child: Image.asset(
                  Assets.getRandomAvatar(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        if (isOwnProfile && enableEditMode)
          Positioned(
            bottom: _height * -5,
            left: _width * 55,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Pellete.kDark.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                IconlyBold.camera,
                color: Pellete.kWhite,
                size: 16,
              ),
            ),
          ),
      ],
    );
  }
}
