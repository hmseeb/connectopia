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

class SigninSuccessState extends SigninState {}

class SigninFailureState extends SigninState {
  final String error;

  SigninFailureState(this.error);
}
