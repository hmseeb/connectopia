import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:connectopia/src/features/search_users/data/search_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:pocketbase/pocketbase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepo _searchRepo = SearchRepo();
  bool hasFoundMedia = false;
  bool hasFoundUsers = false;

  SearchBloc() : super(SearchInitial()) {
    on<SearchUsersEvent>((event, emit) async {
      try {
        if (event.query.isEmpty)
          return emit(SearchInitial());
        else
          emit(SearchLoading());
        ResultList<RecordModel> usersRecord =
            await _searchRepo.searchUsers(event.query);
        List<User> users =
            usersRecord.items.map((e) => User.fromRecord(e)).toList();

        List<RecordModel> postsRecord =
            await _searchRepo.searchPosts(event.query, 'caption');
        List<Post> posts = postsRecord.map((e) => Post.fromRecord(e)).toList();

        if (posts.isNotEmpty)
          hasFoundMedia = true;
        else
          hasFoundMedia = false;

        if (users.isNotEmpty)
          hasFoundUsers = true;
        else
          hasFoundUsers = false;

        emit(SearchLoadedState(users, posts));
        users = [];
        posts = [];
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });

    on<GetUserPosts>((event, emit) async {
      emit(LoadingUserPosts());
      List<RecordModel> postsRecord =
          await _searchRepo.searchPosts(event.id, 'user');
      List<Post> posts = postsRecord.map((e) => Post.fromRecord(e)).toList();
      emit(UserPostsLoadedState(posts, event.index));
    });
  }
}
