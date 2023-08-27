// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:connectopia/src/common/data/errors_repo.dart';
import 'package:connectopia/src/features/authentication/data/repository/auth_repo.dart';
import 'package:connectopia/src/features/authentication/data/repository/validation_repo.dart';
import 'package:connectopia/src/features/feeds/data/feeds_repo.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:equatable/equatable.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  AuthRepo authRepo;
  ValidationRepo fieldValidator = ValidationRepo();
  ErrorHandlerRepo errorHandler = ErrorHandlerRepo();

  SigninBloc(this.authRepo) : super(SigninInitialState()) {
    bool isEmailValid = false;
    bool isPasswordValid = false;

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
      try {
        emit(SigninLoadingState());
        AuthRepo authRepo = AuthRepo();
        await authRepo.signin(event.email, event.password);
        ProfileRepo profileRepo = ProfileRepo();
        FeedsRepo feedsRepo = FeedsRepo();
        late List<Post> posts;
        User user = User.fromRecord(await profileRepo.user);
        final record = await feedsRepo.followingPosts;
        if (record.isEmpty) {
          posts = [];
        } else {
          posts = record.map((post) => Post.fromRecord(post)).toList();
        }
        emit(SigninSuccessState(user, posts));
      } catch (e) {
        ErrorHandlerRepo errorHandler = ErrorHandlerRepo();
        String errorMsg = errorHandler.handleError(e);
        SigninFailureState(errorMsg);
      }
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
