// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/authentication/data/repository/auth_repo.dart';
import 'package:connectopia/src/features/authentication/data/repository/errors_repo.dart';
import 'package:connectopia/src/features/authentication/data/repository/validation_repo.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepo authRepo;
  bool isValidUsername = false;
  bool isValidEmail = false;
  bool isValidPassword = false;

  ValidationRepo fieldValidator = ValidationRepo();
  ErrorHandlerRepo errorHandler = ErrorHandlerRepo();
  SignupBloc(this.authRepo) : super(SignupInitial()) {
    void _checkAllFieldsValidity(Emitter<SignupState> emit) {
      if (isValidUsername && isValidEmail && isValidPassword) {
        emit(ValidState());
      }
    }

    void _handleUsernameChangedEvent(UsernameChangedEvent event, emit) {
      isValidUsername = (fieldValidator.isValidUsername(event.username));
      if (isValidUsername)
        emit(ValidUsernameState());
      else
        emit(InvalidUsernameState());
      _checkAllFieldsValidity(emit);
    }

    void _handleEmailChangedEvent(EmailChangedEvent event, emit) {
      isValidEmail = (fieldValidator.isValidEmail(event.email));
      if (isValidEmail)
        emit(ValidEmailState());
      else
        emit(InvalidEmailState());
      _checkAllFieldsValidity(emit);
    }

    void _handlePasswordChangeEvent(event, emit) {
      isValidPassword = (fieldValidator.isValidPassword(event.password));
      if (isValidPassword)
        emit(ValidPasswordState());
      else
        emit(InvalidPasswordState());
      _checkAllFieldsValidity(emit);
    }

    void _handleSubmitButtonPressedEvent(
        SignupButtonPressedEvent event, emit) async {
      emit(SignupLoadingState());
      final userData = await authRepo
          .signup(event.email, event.password, event.username)
          .then((value) {
        emit(SignupSuccessState());
      }).catchError((error) {
        String errorMsg = errorHandler.handleError(error);
        emit(SignupFailureState(error: errorMsg));
      });
    }

    on<UsernameChangedEvent>(_handleUsernameChangedEvent);

    on<EmailChangedEvent>(_handleEmailChangedEvent);

    on<PasswordChangedEvent>(_handlePasswordChangeEvent);

    on<SignupButtonPressedEvent>(_handleSubmitButtonPressedEvent);

    on<PageChangeEvent>((event, emit) {
      isValidUsername = false;
      isValidEmail = false;
      isValidPassword = false;
      emit(SignupInitial());
    });
  }
}
