part of 'signin_bloc.dart';

sealed class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

class SigninInitialState extends SigninState {}

class ValidState extends SigninState {}

class ValidEmailState extends SigninState {}

class SigninLoadingState extends SigninState {}

class SigninSuccessState extends SigninState {
  final User user;
  final List<Post> posts;
  SigninSuccessState(this.user, this.posts);
}

class SigninFailureState extends SigninState {
  final String error;

  SigninFailureState(this.error);
}

final class SigningWithOAuthState extends SigninState {}

final class SigningWithOAuthFailedState extends SigninState {
  final String error;

  SigningWithOAuthFailedState(this.error);
}

final class SigningWithOAuthSuccessState extends SigninState {}
