import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/authentication/presentation/widgets/auth_text_field.dart';
import 'package:connectopia/src/features/authentication/presentation/widgets/common_sheet.dart';
import 'package:connectopia/src/features/authentication/presentation/widgets/field_title.dart';
import 'package:connectopia/src/theme/pinput.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../theme/colors.dart';

Future<dynamic> forgetPasswordBottomSheet(
    BuildContext context, TextEditingController controller) {
  final _height = ScreenSize.height(context);

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          gradient: Pellete.kBackgroundGradient,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                DragHandle(),
                const SizedBox(height: 30),
                SheetTitle(title: 'Forgot Password'),
                const SizedBox(height: 16),
                const Text(
                    'Enter your email address and we will send you a 4 digit code to reset your password'),
                SizedBox(height: _height * 5),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextFieldTitle(title: 'Email'),
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  avoidBottomInset: true,
                  hintText: 'your email',
                  controller: controller,
                ),
                const SizedBox(height: 80),
                SizedBox(
                  child: ElevatedButton(
                    child: const Text('Continue'),
                    onPressed: () {
                      Navigator.pop(context);
                      codeSentBottomSheet(context, _height, controller);
                    },
                  ),
                ),
                // to scroll up when keyboard appears
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<dynamic> codeSentBottomSheet(
    BuildContext context, double _height, TextEditingController controller) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        gradient: Pellete.kBackgroundGradient,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(_height * ScreenSize.kSpaceL),
          child: Column(
            children: [
              DragHandle(),
              const SizedBox(height: 30),
              SheetTitle(title: 'Enter 4 digit code'),
              const SizedBox(height: 16),
              const Text(
                  'Enter the 4 digit code that you received on your email address'),
              SizedBox(height: _height * 3),
              Pinput(
                scrollPadding: EdgeInsets.all(
                    MediaQuery.viewInsetsOf(context).bottom + 32),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                errorTextStyle: TextStyle(
                  color: Colors.redAccent,
                ),
                defaultPinTheme: PinputTheme.defaultPinTheme,
                focusedPinTheme: PinputTheme.focusedPinTheme,
                submittedPinTheme: PinputTheme.submittedPinTheme,
                errorPinTheme: PinputTheme.errorPinTheme,
                validator: (s) {
                  return s == '2222' ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(height: 80),
              SizedBox(
                child: ElevatedButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.pop(context);
                    resetPasswordBottomSheet(context);
                  },
                ),
              ),
              // to scroll up when keyboard appears
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<dynamic> resetPasswordBottomSheet(BuildContext context) {
  final _height = ScreenSize.height(context);
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        gradient: Pellete.kBackgroundGradient,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(_height * ScreenSize.kSpaceL),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color: Pellete.kWhite.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Set a new password for your account so you can login and access all features',
              ),
              SizedBox(height: _height * 5),
              Align(
                  alignment: Alignment.topLeft,
                  child: TextFieldTitle(title: 'Password')),
              const SizedBox(height: 8),
              AuthTextField(
                avoidBottomInset: true,
                hintText: 'New password',
              ),
              SizedBox(height: _height * 5),
              Align(
                  alignment: Alignment.topLeft,
                  child: TextFieldTitle(title: 'Confirm Password')),
              const SizedBox(height: 8),
              AuthTextField(
                avoidBottomInset: true,
                hintText: 'Confirm new password',
              ),
              const SizedBox(height: 40),

              SizedBox(
                child: ElevatedButton(
                  child: const Text('Reset Password'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // to scroll up when keyboard appears
              SizedBox(height: MediaQuery.viewInsetsOf(context).bottom),
            ],
          ),
        ),
      ),
    ),
  );
}
