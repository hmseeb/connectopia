import 'package:bloc/bloc.dart';
import '../../../../db/pocketbase.dart';
import 'package:equatable/equatable.dart';

part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class AccountSettings
    extends Bloc<AccountSettingssEvent, AccountSettingssState> {
  AccountSettings() : super(AccountSettingssInitial()) {
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
  }
}
