part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

class ValidState extends SignupState {}

class ValidUsernameState extends SignupState {}

class ValidEmailState extends SignupState {}

class ValidPasswordState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupFailureState extends SignupState {
  final String error;

  SignupFailureState({required this.error});

  @override
  List<Object> get props => [error];
}
