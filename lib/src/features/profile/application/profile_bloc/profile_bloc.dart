import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo repo = ProfileRepo();

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final record = await repo.user;
        User user = User.fromRecord(record);
        debugPrint(user.avatar);
        emit(ProfileLoadedState(user));
      } catch (e) {
        emit(ProfileLoadingFailedState(e.toString()));
      }
    });
  }
}
