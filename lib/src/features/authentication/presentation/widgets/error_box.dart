import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(top: 8),
      duration: Duration(milliseconds: 300),
      height: message!.isEmpty || message == null
          ? 0
          : message!.length > 50
              ? 70
              : 30,
      child: Text(
        message ?? '',
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 16,
        ),
      ),
    );
  }
}
