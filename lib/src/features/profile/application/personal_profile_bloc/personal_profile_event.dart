part of 'personal_profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class LoadPersonalProfile extends ProfileEvent {
  const LoadPersonalProfile();
}

final class DeletePostButtonPressed extends ProfileEvent {
  const DeletePostButtonPressed(this.postId, this.user);
  final String postId;
  final User user;
}
