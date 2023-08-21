import 'dart:math';

class Assets {
  static String logo = 'assets/images/logo.png';
  static String splash = 'assets/animations/rive/splash.riv';
  static String person1 =
      'https://i.pinimg.com/564x/c5/08/0b/c5080b066465a59873521e2c21d0ee37.jpg';
  static String person2 =
      'https://i.pinimg.com/564x/9d/98/4d/9d984d97b424837500d44c87d1a37309.jpg';
  static String person3 =
      'https://i.pinimg.com/564x/df/27/66/df2766f09b7a6ae23a9ec9dd9084896a.jpg';
  static String person4 =
      'https://i.pinimg.com/564x/43/3d/03/433d0346af08d5f9814b535c55aaf32e.jpg';
  static String progressIndicator =
      'assets/animations/lottie/progress_indicator.json';

  static String successAnimation =
      'assets/animations/lottie/success_animation.json';
  static String avatarPlaceholder =
      'assets/images/placeholders/avatar_placeholder.avif';
  static String bannerPlaceholder =
      'assets/images/placeholders/banner_placeholder.png';
  static String getRandomAvatar() {
    List<String> avatars = [
      'cat',
      'cow',
      'deer',
      'jacutinga',
      'koi',
      'macaw',
      'panda-bear',
      'shark',
    ];
    int randomIndex = Random().nextInt(avatars.length);
    return 'assets/images/placeholders/${avatars[randomIndex]}.png';
  }

  static String get randomImage {
    List<String> urls = [
      'https://source.unsplash.com/random/720x720',
      'https://source.unsplash.com/user/erondu/720x720',
      'https://source.unsplash.com/720x720/?nature,water',
      'https://source.unsplash.com/WLUHO9A_xik/720x720',
      'https://source.unsplash.com/TCpfPxKPOvk/720x720'
    ];

    int randomIndex = Random().nextInt(urls.length);

    return urls[randomIndex];
  }
}
