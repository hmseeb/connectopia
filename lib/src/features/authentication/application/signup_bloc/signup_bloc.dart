import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/authentication/domain/repository/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepo authRepo;
  bool isValidUsername = false;
  bool isValidEmail = false;
  bool isValidPassword = false;

  SignupBloc(this.authRepo) : super(SignupInitial()) {
    void _checkAllFieldsValidity(Emitter<SignupState> emit) {
      if (isValidUsername && isValidEmail && isValidPassword) {
        emit(ValidState());
      }
    }

    void _handleUsernameChangedEvent(event, emit) {
      isValidUsername = (authRepo.isValidUsername(event.username));
      if (isValidUsername) emit(ValidUsernameState());

      _checkAllFieldsValidity(emit);
    }

    void _handleEmailChangedEvent(event, emit) {
      isValidEmail = (authRepo.isValidEmail(event.email));
      if (isValidEmail) emit(ValidEmailState());
      _checkAllFieldsValidity(emit);
    }

    void _handlePasswordChangeEvent(event, emit) {
      isValidPassword = (authRepo.isValidPassword(event.password));
      if (isValidPassword) emit(ValidPasswordState());
      _checkAllFieldsValidity(emit);
    }

    void _handleSubmitButtonPressedEvent(event, emit) {
      emit(SignupLoadingState());
      authRepo
          .signup(event.username, event.email, event.password)
          .then((value) {
        emit(SignupSuccessState());
      }).catchError((error) {
        emit(SignupFailureState(error: error.toString()));
      });
    }

    on<UsernameChangedEvent>(_handleUsernameChangedEvent);

    on<EmailChangedEvent>(_handleEmailChangedEvent);

    on<PasswordChangedEvent>(_handlePasswordChangeEvent);

    on<SignupButtonPressedEvent>(_handleSubmitButtonPressedEvent);
  }

  bool get usernameValid => isValidUsername;
  bool get emailValid => isValidEmail;
  bool get passwordValid => isValidPassword;
}
