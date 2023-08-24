import 'package:bloc/bloc.dart';
import 'package:connectopia/src/common/data/errors_repo.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../../db/pocketbase.dart';

part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class AccountSettings extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  AccountSettings() : super(AccountSettingsInitial()) {
    on<SignOutButtonPressedEvent>((event, emit) async {
      emit(AccountSettingsLoading());
      final pb = await PocketBaseSingleton.instance;
      try {
        pb.authStore.clear();
        emit(SignoutSuccess());
      } catch (e) {
        emit(SignoutError(e.toString()));
      }
    });
    on<ToggleAccountPrivacyEvent>((event, emit) async {
      emit(TogglePrivacyLoading());
      try {
        ProfileRepo profileRepo = ProfileRepo();
        final toggle = await profileRepo.updateProfilePrivacy(event.toggle);
        emit(TogglePrivacySuccess(toggle));
      } catch (e) {
        ErrorHandlerRepo errorHandlerRepo = ErrorHandlerRepo();
        String errorMsg = errorHandlerRepo.handleError(e);
        emit(TogglePrivacyError(errorMsg));
      }
    });
  }
}
