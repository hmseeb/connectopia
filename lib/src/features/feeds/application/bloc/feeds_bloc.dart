import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/feeds/data/feeds_repo.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:equatable/equatable.dart';

part 'feeds_event.dart';
part 'feeds_state.dart';

class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  FeedsBloc() : super(FeedsInitial()) {
    on<ValidUserAuthEvent>((event, emit) async {
      final DateTime startTime = DateTime.now(); // Store the start time

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
      final int loadingTime = DateTime.now().difference(startTime).inSeconds;
      final int remainingTime = loadingTime >= 3 ? 0 : 3 - loadingTime;

      await Future.delayed(
          Duration(seconds: remainingTime)); // Ensure a minimum of 3 seconds

      final int totalLoadingTime =
          DateTime.now().difference(startTime).inMilliseconds;
      emit(FeedsLoadedState(user, posts));
      print('Loaded feeds in ${totalLoadingTime}ms');
    });
  }
}
