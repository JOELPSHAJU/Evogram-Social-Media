part of 'get_comments_bloc.dart';

@immutable
sealed class GetCommentsEvent {}

class CommentsFetchEvent extends GetCommentsEvent {
  final String postId;

  CommentsFetchEvent({required this.postId});
}
