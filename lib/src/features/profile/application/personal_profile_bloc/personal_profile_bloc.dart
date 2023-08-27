import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/data/errors_repo.dart';
import '../../data/repository/profile_repo.dart';
import '../../domain/models/post.dart';

part 'personal_profile_event.dart';
part 'personal_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo repo = ProfileRepo();
  ErrorHandlerRepo handleError = ErrorHandlerRepo();

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadPersonalProfile>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final post_record = await repo.personalPosts;
        List<Post> posts =
            post_record.map((post) => Post.fromRecord(post)).toList();
        late final User user;
        if (posts.isEmpty) {
          final user_record = await repo.user;
          user = User.fromRecord(user_record);
        } else {
          user = posts.first.expand.user;
        }
        emit(ProfileLoadedState(posts, user));
      } catch (e) {
        String errorMsg = handleError.handleError(e);
        emit(ProfileLoadingFailedState(errorMsg));
      }
    });

    on<DeletePostButtonPressed>(
      (event, emit) {
        emit(ProfileLoadingState());
        try {
          repo.deletePost(event.postId);
          emit(ProfilePostDeletedState(event.user));
        } catch (e) {
          String errorMsg = handleError.handleError(e);
          emit(ProfileLoadingFailedState(errorMsg));
        }
      },
    );
  }
}
