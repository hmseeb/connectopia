import 'package:bloc/bloc.dart';
import 'package:connectopia/src/common/data/errors_repo.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  bool isFollowing = false;
  ProfileRepo repo = ProfileRepo();
  ErrorHandlerRepo handleError = ErrorHandlerRepo();
  UserProfileBloc() : super(UserProfileInitial()) {
    on<LoadUserProfile>((event, emit) async {
      isFollowing = await repo.isFollowing(event.id!);
      emit(UserProfileLoadedState(isFollowing));
    });

    on<FollowButtonPressed>((event, emit) async {
      emit(FollowingLoadingState());
      try {
        await repo.followUser(event.id);
        emit(FollowedSuccessfulState());
      } catch (e) {
        String errorMsg = handleError.handleError(e);
        emit(FollowedFailedState(errorMsg));
      }
    });
    on<UnfollowButtonPressed>((event, emit) async {
      emit(FollowingLoadingState());
      try {
        await repo.unfollow(event.id);
        emit(FollowedSuccessfulState());
      } catch (e) {
        String errorMsg = handleError.handleError(e);
        emit(FollowedFailedState(errorMsg));
      }
    });
  }
}
