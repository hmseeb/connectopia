import 'dart:math';

import 'package:logger/logger.dart';

class ErrorHandlerRepo {
  Logger logger = Logger();
  String handleError(Object? error) {
    String errorMsg = error.toString();
    logger.e(errorMsg);
    if (errorMsg.contains('validation_invalid_email')) {
      return 'Email invalid or already taken';
    } else if (errorMsg.contains('validation_invalid_username')) {
      return 'Username invalid or already taken';
    }
    int randomIndex = Random().nextInt(errors.length);
    return errors[randomIndex];
  }

  List<String> errors = [
    "We are embarassed! Human Error is inevitable, but this is unacceptable. We'll look into the matter now.",
    'There was a glitch in the matrix...',
    "Oops, you've might have overlooked some fields.",
    "Less is more, but we need more information before we can proceed.",
    "Happens to the best of us, you've might have missed out some fields."
  ];
}
