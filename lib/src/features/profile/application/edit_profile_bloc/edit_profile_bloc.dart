import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/authentication/data/repository/validation_repo.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  String username = '';
  String displayName = '';
  String bio = '';

  ValidationRepo validationRepo = ValidationRepo();
  ProfileRepo profileRepo = ProfileRepo();

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
      emit(EditCanSubmit());
    });

    on<SubmitButtonPressedEvent>((event, emit) async {
      emit(EditProfileLoading());
      await profileRepo
          .updateProfile(event.username, event.displayName, event.bio)
          .then((value) {
        emit(EditProfileSuccess());
      }).catchError((e) {
        emit(EditProfileFailure(e.toString()));
      });
    });

    on<RequestEmailVerification>((event, emit) async {
      try {
        emit(EmailVerificationSending());
        await profileRepo.requestVerification(event.email);
        emit(EmailVerificationSent());
      } catch (e) {
        Logger logger = Logger();
        logger.e(e);
      }
    });

    void _handleImagePicker(event, emit) async {
      if (await Permission.camera.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        late XFile? pickedImage;
        try {
          final ImagePicker imagePicker = ImagePicker();
          pickedImage = await imagePicker.pickImage(
            source: ImageSource.gallery,
          );
          if (pickedImage != null) {
            if (event is AvatarPickerButtonPressed) {
              try {
                emit(EditProfileLoading());
                await profileRepo.updateAvatarOrBanner(pickedImage, 'avatar');
                emit(EditProfileSuccess());
                emit(EditProfileInitial());
              } catch (e) {
                emit(EditProfileFailure(e.toString()));
              }
            } else if (event is BannerPickerButtonPressed) {
              try {
                emit(EditProfileLoading());
                await profileRepo.updateAvatarOrBanner(pickedImage, 'banner');
                emit(EditProfileSuccess());
                emit(EditProfileInitial());
              } catch (e) {
                emit(EditProfileFailure(e.toString()));
              }
            }
          }
        } catch (e) {
          Logger logger = Logger();
          logger.e(e);
          emit(EditProfileFailure(e.toString()));
        }
      }
    }

    on<AvatarPickerButtonPressed>(_handleImagePicker);
    on<BannerPickerButtonPressed>(_handleImagePicker);
  }
}
