part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileUsernameChangedEvent extends EditProfileEvent {
  const EditProfileUsernameChangedEvent(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class EditProfileDisplayNameChangedEvent extends EditProfileEvent {
  const EditProfileDisplayNameChangedEvent(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class EditProfileBioChangedEvent extends EditProfileEvent {
  const EditProfileBioChangedEvent(this.bio);

  final String bio;

  @override
  List<Object> get props => [bio];
}
