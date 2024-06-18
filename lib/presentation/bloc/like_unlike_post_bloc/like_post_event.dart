part of 'like_post_bloc.dart';

@immutable
sealed class LikePostEvent {}

class LikePostButtonClickEvent extends LikePostEvent {
  final String postId;

  LikePostButtonClickEvent({required this.postId});
}

class UnlikePostButtonClickEvent extends LikePostEvent {
  final String postId;

  UnlikePostButtonClickEvent({required this.postId});
}
