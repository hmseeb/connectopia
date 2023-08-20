import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/authentication/data/repository/validation_repo.dart';
import 'package:equatable/equatable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  String username = '';
  String displayName = '';
  String bio = '';

  ValidationRepo validationRepo = ValidationRepo();

  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileUsernameChangedEvent>((event, emit) {
      bool validUsername = validationRepo.isValidUsername(event.username);
      if (validUsername) {
        emit(EditCanSubmit());
        username = event.username;
      } else {
        emit(EditProfileInitial());
      }
    });

    on<EditProfileDisplayNameChangedEvent>((event, emit) {
      displayName = event.name;
      if (displayName.isNotEmpty) {
        emit(EditCanSubmit());
      } else {
        emit(EditProfileInitial());
      }
    });
    on<EditProfileBioChangedEvent>((event, emit) {
      bio = event.bio;
      if (bio.isNotEmpty) {
        emit(EditCanSubmit());
      } else {
        emit(EditProfileInitial());
      }
    });
  }
}
