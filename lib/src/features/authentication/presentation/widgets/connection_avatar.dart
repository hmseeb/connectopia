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
      radius: 45,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: Image.network(
          img,
          width: 50, // Make sure width and height are the same
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
