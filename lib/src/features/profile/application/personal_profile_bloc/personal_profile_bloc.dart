import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/data/errors_repo.dart';
import '../../data/repository/profile_repo.dart';
import '../../domain/models/post.dart';

part 'personal_profile_event.dart';
part 'personal_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late User user;
  List<Post> posts = [];
  ProfileRepo repo = ProfileRepo();
  ErrorHandlerRepo handleError = ErrorHandlerRepo();

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadPersonalProfile>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final startedTime = Stopwatch()..start();
        final post_record = await repo.personalPosts;
        posts = post_record.map((post) => Post.fromRecord(post)).toList();
        if (posts.isEmpty) {
          final user_record = await repo.user;
          user = User.fromRecord(user_record);
        } else {
          user = posts.first.expand.user;
        }
        print('${startedTime.elapsedMilliseconds}ms');
        Stopwatch()..stop();
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
