part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class LoadUserProfile extends ProfileEvent {
  const LoadUserProfile();
}

final class DeletePostButtonPressed extends ProfileEvent {
  const DeletePostButtonPressed(this.postId);
  final String postId;
}
