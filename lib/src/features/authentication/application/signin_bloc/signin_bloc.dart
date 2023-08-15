import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/authentication/domain/repository/signin_repo.dart';
import 'package:equatable/equatable.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final signinRepo = SigninRepository();

  SigninBloc() : super(SigninInitialState()) {
    on<EmailOrPasswordChanged>((event, emit) {
      if (!signinRepo.isEmailValid(event.email)) {
        emit(InvalidEmailState('Enter a valid email address'));
      } else if (!signinRepo.isValidPassword(event.password)) {
        if (event.password == '')
          emit(SigninInitialState());
        else
          emit(InvalidPasswordState(
              'Your password must be at least 8 characters long and contain at least one number and one special character'));
      } else {
        emit(ValidSigninState());
      }
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
