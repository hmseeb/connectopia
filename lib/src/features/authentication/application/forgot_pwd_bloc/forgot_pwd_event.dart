part of 'forgot_pwd_bloc.dart';

sealed class ForgotPwdEvent extends Equatable {
  const ForgotPwdEvent();

  @override
  List<Object> get props => [];
}

class EmailChangedEvent extends ForgotPwdEvent {
  final String email;

  EmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class EmailSubmittedEvent extends ForgotPwdEvent {
  final String email;

  EmailSubmittedEvent(this.email);

  @override
  List<Object> get props => [email];
}


