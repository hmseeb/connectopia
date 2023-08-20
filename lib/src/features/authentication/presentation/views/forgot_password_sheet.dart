import '../../../../common/messages/error_snakbar.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/sizing.dart';
import '../../application/forgot_pwd_bloc/forgot_pwd_bloc.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/common_sheet.dart';
import '../widgets/field_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../theme/colors.dart';

Future<dynamic> forgetPasswordBottomSheet(
    BuildContext context, TextEditingController emailController) {
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
                    'Enter your email address and we will send you a link to reset your password'),
                SizedBox(height: _height * 5),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextFieldTitle(title: 'Email'),
                ),
                const SizedBox(height: 8),
                BlocBuilder<ForgotPwdBloc, ForgotPwdState>(
                  builder: (context, state) {
                    return AuthTextField(
                      onChanged: (value) {
                        context
                            .read<ForgotPwdBloc>()
                            .add(EmailChangedEvent(value));
                      },
                      avoidBottomInset: true,
                      hintText: 'Enter your email',
                      controller: emailController,
                      suffixIcon: state is ValidEmailState
                          ? Icon(Icons.check_box, color: Pellete.kPrimary)
                          : null,
                    );
                  },
                ),
                const SizedBox(height: 80),
                SizedBox(
                  child: BlocConsumer<ForgotPwdBloc, ForgotPwdState>(
                    listener: (context, state) {
                      if (state is EmailNotSentState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnack(state.error));
                      } else if (state is EmailSentState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            successSnack('Email sent successfully'));
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        child: state is SendingEmailState
                            ? Lottie.asset(Assets.progressIndicator)
                            : state is EmailSentState
                                ? const Text('Email Sent')
                                : const Text('Send Email'),
                        onPressed: state is ValidEmailState
                            ? () {
                                context.read<ForgotPwdBloc>().add(
                                    EmailSubmittedEvent(emailController.text));
                              }
                            : null,
                      );
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
