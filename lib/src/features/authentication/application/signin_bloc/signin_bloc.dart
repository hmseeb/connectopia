import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/authentication/domain/repository/signin_repo.dart';
import 'package:equatable/equatable.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final signinRepo = SigninRepository();

  SigninBloc() : super(SigninInitialState()) {
    bool isEmailValid = false;
    bool isPasswordValid = false;

    on<EmailChangedEvent>((event, emit) {
      isEmailValid = signinRepo.isValidEmail(event.email);
      if (isEmailValid && isPasswordValid)
        emit(ValidState());
      else
        emit(SigninInitialState());
    });

    on<PasswordChangedEvent>((event, emit) {
      isPasswordValid = signinRepo.isValidPassword(event.password);
      if (isEmailValid && isPasswordValid)
        emit(ValidState());
      else
        emit(SigninInitialState());
    });

    on<SigninButtonPressed>((event, emit) async {
      emit(SigninLoadingState());
      bool success = await signinRepo.signin(event.email, event.password);
      if (success) {
        emit(SigninFailureState('Failed to sign in'));
      } else {
        emit(SigninFailureState('Failed to sign in'));
      }
    });
  }
}
