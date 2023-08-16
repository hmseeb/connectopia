import 'package:flutter/material.dart';

import '../../features/authentication/application/signin_bloc/signin_bloc.dart';
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
