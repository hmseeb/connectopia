part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

final class GallaryButtonClickedEvent extends CreatePostEvent {}

final class CameraButtonClickedEvent extends CreatePostEvent {}

final class LocationButtonClickedEvent extends CreatePostEvent {}

final class ToggleStoryButtonClickedEvent extends CreatePostEvent {}
