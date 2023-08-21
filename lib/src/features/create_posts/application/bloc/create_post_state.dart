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
