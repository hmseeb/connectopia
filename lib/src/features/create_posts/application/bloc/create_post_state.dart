part of 'create_post_bloc.dart';

sealed class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object> get props => [];
}

final class CreatePostInitial extends CreatePostState {}

final class PickedImageFromGallery extends CreatePostState {
  const PickedImageFromGallery({
    required this.pickedFile,
  });

  final List<XFile?> pickedFile;

  @override
  List<Object> get props => [pickedFile];
}

final class CapturedPhoto extends CreatePostState {
  const CapturedPhoto({
    required this.capturedPhoto,
  });

  final XFile? capturedPhoto;

  @override
  List<Object> get props => [capturedPhoto!];
}

final class CreatingPost extends CreatePostState {}

final class PostCreationFailure extends CreatePostState {
  final String error;

  const PostCreationFailure(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

final class CreatedPost extends CreatePostState {}

final class ValidSubmitState extends CreatePostState {}

final class ToggleLocation extends CreatePostState {
  final bool toggleLocation;

  const ToggleLocation(this.toggleLocation);

  @override
  List<Object> get props => [toggleLocation];
}

final class ToggleStory extends CreatePostState {
  final bool toggleStory;

  const ToggleStory(this.toggleStory);

  @override
  List<Object> get props => [toggleStory];
}
