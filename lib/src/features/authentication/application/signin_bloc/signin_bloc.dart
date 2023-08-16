// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/authentication/data/repository/auth_repo.dart';
import 'package:connectopia/src/features/authentication/data/repository/errors_repo.dart';
import 'package:connectopia/src/features/authentication/data/repository/validation_repo.dart';
import 'package:equatable/equatable.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  AuthRepo authRepo;

  SigninBloc(this.authRepo) : super(SigninInitialState()) {
    bool isEmailValid = false;
    bool isPasswordValid = false;

    ValidationRepo fieldValidator = ValidationRepo();
    ErrorHandlerRepo errorHandler = ErrorHandlerRepo();

    on<EmailOrPasswordChangedEvent>((event, emit) {
      isEmailValid = fieldValidator.isValidEmail(event.email) ||
          fieldValidator.isValidUsername(event.email);
      isPasswordValid = fieldValidator.isValidPassword(event.password);
      if (isEmailValid && isPasswordValid)
        emit(ValidState());
      else if (isEmailValid)
        emit(ValidEmailState());
      else
        emit(SigninInitialState());
    });

    on<SigninButtonPressed>((event, emit) async {
      emit(SigninLoadingState());
      final userData = await authRepo
          .signin(event.email, event.password)
          .then((value) => emit(SigninSuccessState()))
          .onError((error, stackTrace) {
        String errorMsg = errorHandler.handleError(error);
        emit(SigninFailureState(errorMsg));
      });
    });

    on<SigninWithGoogleButtonPressed>((event, emit) async {
      await authRepo
          .signinWithOAuth('google')
          .then((value) => emit(SigningWithOAuthSuccessState()))
          .onError((error, stackTrace) {
        String errorMsg = errorHandler.handleError(error);
        emit(SigningWithOAuthFailedState(errorMsg));
        emit(SigninInitialState());
      });
    });
    on<SigninWithFacebookButtonPressed>((event, emit) async {
      await authRepo
          .signinWithOAuth('facebook')
          .then((value) => emit(SigningWithOAuthSuccessState()))
          .onError((error, stackTrace) {
        String errorMsg = errorHandler.handleError(error);
        emit(SigningWithOAuthFailedState(errorMsg));
        emit(SigninInitialState());
      });
    });

    on<PageChangeEvent>((event, emit) {
      emit(SigninInitialState());
    });
  }
}
