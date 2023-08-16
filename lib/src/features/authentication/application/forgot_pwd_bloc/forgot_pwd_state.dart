part of 'forgot_pwd_bloc.dart';

sealed class ForgotPwdState extends Equatable {
  const ForgotPwdState();

  @override
  List<Object> get props => [];
}

final class ForgotPwdInitial extends ForgotPwdState {}

final class ValidEmailState extends ForgotPwdState {}

final class SendingEmailState extends ForgotPwdState {}

final class EmailSentState extends ForgotPwdState {}

final class EmailNotSentState extends ForgotPwdState {
  final String error;

  EmailNotSentState(this.error);

  @override
  List<Object> get props => [error];
}
