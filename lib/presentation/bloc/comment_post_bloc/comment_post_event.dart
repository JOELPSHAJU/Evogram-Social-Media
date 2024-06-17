part of 'comment_post_bloc.dart';

@immutable
sealed class CommentPostEvent {}

class CommentPostButtonClickEvent extends CommentPostEvent {
  final String userName;
  final String postId;
  final String content;

  CommentPostButtonClickEvent(
      {required this.userName, required this.postId, required this.content});
}
