import 'package:bloc/bloc.dart';
import 'package:connectopia/src/common/data/errors_repo.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  ProfileRepo repo = ProfileRepo();
  ErrorHandlerRepo handleError = ErrorHandlerRepo();
  UserProfileBloc() : super(UserProfileInitial()) {
    on<LoadUserProfile>((event, emit) async {
      emit(UserProfileLoadingState());
      List<Post> posts = event.posts!;
      User user = event.user!;
      bool isFollowing = await repo.isFollowing(event.id!);
      emit(UserProfileLoadedState(posts, user, isFollowing: isFollowing));
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
