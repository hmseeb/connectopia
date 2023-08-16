import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/authentication/data/repository/auth_repo.dart';
import 'package:connectopia/src/features/authentication/data/repository/validation_repo.dart';
import 'package:equatable/equatable.dart';

part 'forgot_pwd_event.dart';
part 'forgot_pwd_state.dart';

class ForgotPwdBloc extends Bloc<ForgotPwdEvent, ForgotPwdState> {
  ValidationRepo fieldValidator = ValidationRepo();
  AuthRepo authRepo;
  ForgotPwdBloc(this.authRepo) : super(ForgotPwdInitial()) {
    _handleEmailChanged(event, emit) {
      if (fieldValidator.isValidEmail(event.email))
        emit(ValidEmailState());
      else
        emit(ForgotPwdInitial());
    }

    on<EmailChangedEvent>(_handleEmailChanged);
    on<EmailSubmittedEvent>(
      (event, emit) {
        emit(SendingEmailState());
        authRepo
            .sendVerificationEmail(event.email)
            .then((value) => emit(EmailSentState()))
            .catchError((e) => emit(EmailNotSentState('An error occured')));
      },
    );
  }
}
