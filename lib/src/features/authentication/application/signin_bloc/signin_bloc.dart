// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/authentication/domain/repository/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  AuthRepo authRepo;

  SigninBloc(this.authRepo) : super(SigninInitialState()) {
    bool isEmailValid = false;
    bool isPasswordValid = false;

    on<EmailOrPasswordChangedEvent>((event, emit) {
      isEmailValid = authRepo.isValidEmail(event.email);
      isPasswordValid = authRepo.isValidPassword(event.password);
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
        emit(SigninFailureState(error.toString()));
      });
    });
  }
}
