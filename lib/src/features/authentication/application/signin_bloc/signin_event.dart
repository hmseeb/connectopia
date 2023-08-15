part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

final class EmailChangedEvent extends SigninEvent {
  EmailChangedEvent(this.email);
  final String email;
  List<Object> get props => [email];
}

final class PasswordChangedEvent extends SigninEvent {
  PasswordChangedEvent(this.password);
  final String password;
  List<Object> get props => [password];
}

final class SigninButtonPressed extends SigninEvent {
  SigninButtonPressed(this.email, this.password);
  final String email;
  final String password;
  List<Object> get props => [email, password];
}
