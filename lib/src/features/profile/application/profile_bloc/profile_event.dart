part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class LoadProfileEvent extends ProfileEvent {}

final class DeletePostButtonPressed extends ProfileEvent {
  const DeletePostButtonPressed(this.postId);
  final String postId;
}
