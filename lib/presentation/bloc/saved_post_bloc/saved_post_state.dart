part of 'saved_post_bloc.dart';

@immutable
sealed class SavedPostState {}

final class SavedPostInitial extends SavedPostState {}

final class SavePostLoadingState extends SavedPostState {}

final class SavePostSuccesfulState extends SavedPostState {
  final SavePostModel post;

  SavePostSuccesfulState({required this.post});
}

final class SavePostServerErrorState extends SavedPostState {}

final class SavePostErrorState extends SavedPostState {}

final class RemoveSavedPostSuccesfulState extends SavedPostState {}

final class RemoveSavedPostLoadingState extends SavedPostState {}

final class RemoveSavedPostServerErrorState extends SavedPostState {}

final class RemoveSavedPostErrorState extends SavedPostState {}
