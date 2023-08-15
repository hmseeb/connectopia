part of 'signin_bloc.dart';

sealed class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

class SigninInitialState extends SigninState {}

class SigninLoadingState extends SigninState {}

class ValidSigninState extends SigninState {}

class InvalidEmailState extends SigninState {
  final String error;

  InvalidEmailState(this.error);
}

class InvalidPasswordState extends SigninState {
  final String error;

  InvalidPasswordState(this.error);
}

class SigninSuccessState extends SigninState {}
class SigninFailureState extends SigninState {
  final String error;

  SigninFailureState(this.error);
}
