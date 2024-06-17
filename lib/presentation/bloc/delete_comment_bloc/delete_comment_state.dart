part of 'delete_comment_bloc.dart';

@immutable
sealed class DeleteCommentState {}

final class DeleteCommentInitial extends DeleteCommentState {}

final class DeleteCommentLoadingState extends DeleteCommentState {}

final class DeleteCommentSuccesfulState extends DeleteCommentState {
  final String commentId;

  DeleteCommentSuccesfulState({required this.commentId});
}

final class DeleteCommentCommentNotFoundState extends DeleteCommentState {}

final class DeleteCommentServerErrorState extends DeleteCommentState {}
