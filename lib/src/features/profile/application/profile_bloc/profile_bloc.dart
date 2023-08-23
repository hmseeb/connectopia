import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/data/errors_repo.dart';
import '../../data/repository/profile_repo.dart';
import '../../domain/models/post.dart';
import '../../domain/models/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo repo = ProfileRepo();
  ErrorHandlerRepo handleError = ErrorHandlerRepo();

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final user_record = await repo.user;
        User user = User.fromRecord(user_record);
        final post_record = await repo.post;
        List<Post> posts =
            post_record.map((post) => Post.fromRecord(post)).toList();
        emit(ProfileLoadedState(user, posts));
      } catch (e) {
        String errorMsg = handleError.handleError(e);
        emit(ProfileLoadingFailedState(errorMsg));
      }
    });

    on<DeletePostButtonPressed>((event, emit) {
      emit(ProfileLoadingState());
      try {
        repo.deletePost(event.postId);
        emit(ProfilePostDeletedState());
      } catch (e) {
        String errorMsg = handleError.handleError(e);
        emit(ProfileLoadingFailedState(errorMsg));
      }
    },);
  }
}
