part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

final class FollowButtonPressed extends UserProfileEvent {
  const FollowButtonPressed(this.id);
  final String id;
}

final class UnfollowButtonPressed extends UserProfileEvent {
  const UnfollowButtonPressed(this.id);
  final String id;
}

final class LoadUserProfile extends UserProfileEvent {
  const LoadUserProfile(this.posts, this.user, this.id);
  final List<Post>? posts;
  final User? user;
  final String? id;
}
