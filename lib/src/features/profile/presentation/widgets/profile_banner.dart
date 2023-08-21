import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/profile/application/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:connectopia/src/features/profile/presentation/widgets/profile_button.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconly/iconly.dart';

class PictureBanner extends StatelessWidget {
  const PictureBanner({
    super.key,
    required this.isOwnProfile,
    required this.enableEditMode,
    required this.avatarUrl,
    required this.bannerUrl,
    required this.userId,
  });

  final bool isOwnProfile;
  final bool enableEditMode;
  final String avatarUrl;
  final String bannerUrl;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final baseUrl = dotenv.env['BASE_IMAGE_URL'];
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Opacity(
          opacity: enableEditMode ? 0.5 : 1,
          child: AspectRatio(
            aspectRatio: 2,
            child: bannerUrl.isEmpty
                ? Image.asset(
                    Assets.bannerPlaceholder,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    "${baseUrl}/${userId}/${bannerUrl}",
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        if (enableEditMode)
          Positioned(
              top: _height * 10,
              left: _width * 25,
              child: EditBannerButton(
                text: 'UPDATE COVER PHOTO',
                onPressed: () {
                  debugPrint('Update Banner');
                  context
                      .read<EditProfileBloc>()
                      .add(BannerPickerButtonPressed());
                },
              )),
        if (enableEditMode)
          Positioned(
              top: _height * 5,
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
              child: avatarUrl.isEmpty
                  ? Image.asset(
                      Assets.avatarPlaceholder,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "${baseUrl}/${userId}/${avatarUrl}",
                      fit: BoxFit.cover,
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
