part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class UsernameChangedEvent extends SignupEvent {
  final String username;

  const UsernameChangedEvent(this.username);

  @override
  List<Object> get props => [username];
}

class EmailChangedEvent extends SignupEvent {
  final String email;

  const EmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChangedEvent extends SignupEvent {
  final String password;

  const PasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

class SignupButtonPressedEvent extends SignupEvent {
  SignupButtonPressedEvent(
    this.email,
    this.password,
    this.username,
  );

  final String email;
  final String password;
  final String username;

  @override
  List<Object> get props => [email, password, username];
}

final class PageChangeEvent extends SignupEvent {}
