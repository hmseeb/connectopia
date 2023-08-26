part of 'personal_profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class LoadPersonalProfile extends ProfileEvent {
  const LoadPersonalProfile();
}

final class FollowButtonPressed extends ProfileEvent {
  const FollowButtonPressed(this.id);
  final String id;
}
final class UnfollowButtonPressed extends ProfileEvent {
  const UnfollowButtonPressed(this.id);
  final String id;
}

final class LoadUserProfile extends ProfileEvent {
  const LoadUserProfile(this.posts, this.user, this.id);
  final List<Post>? posts;
  final User? user;
  final String? id;
}

final class DeletePostButtonPressed extends ProfileEvent {
  const DeletePostButtonPressed(this.postId, this.user);
  final String postId;
  final User user;
}

final class ReportPostButtonPressed extends ProfileEvent {
  const ReportPostButtonPressed(this.postId);
  final String postId;
}
