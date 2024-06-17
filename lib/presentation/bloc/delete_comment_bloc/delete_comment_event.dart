part of 'delete_comment_bloc.dart';

@immutable
sealed class DeleteCommentEvent {}

class DeleteCommentButtonClickEvent extends DeleteCommentEvent {
  final String commentId;

  DeleteCommentButtonClickEvent({required this.commentId});
}
