part of 'saved_post_bloc.dart';

@immutable
sealed class SavedPostEvent {}

class SavePostButtonClickEvent extends SavedPostEvent {
  final String postId;

  SavePostButtonClickEvent({required this.postId});
}

class RemoveSavedPostButtonClickEvent extends SavedPostEvent {
  final String postId;

  RemoveSavedPostButtonClickEvent({required this.postId});
}
