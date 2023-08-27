import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ConnectionAvatar extends StatelessWidget {
  const ConnectionAvatar({
    Key? key,
    required this.img,
  }) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.transparent,
      backgroundImage: CachedNetworkImageProvider(img),
    );
  }
}
