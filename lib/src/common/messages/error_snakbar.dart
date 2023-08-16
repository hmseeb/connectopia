import 'package:flutter/material.dart';

import '../../theme/colors.dart';

SnackBar errorSnack(String error) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Center(
        child: Text(
      error,
      style: TextStyle(color: Pellete.kWhite, fontWeight: FontWeight.bold),
    )),
    backgroundColor: Colors.red,
  );
}

SnackBar successSnack(String message) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Center(
        child: Text(
      message,
      style: TextStyle(color: Pellete.kWhite, fontWeight: FontWeight.bold),
    )),
    backgroundColor: Pellete.kSecondary,
  );
}
