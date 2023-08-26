part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class LoadPersonalProfile extends ProfileEvent {
  const LoadPersonalProfile();
}

final class LoadUserProfile extends ProfileEvent {
  const LoadUserProfile(this.posts, this.user);
  final List<Post>? posts;
  final User? user;
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
