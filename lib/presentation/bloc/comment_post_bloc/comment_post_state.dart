part of 'comment_post_bloc.dart';

@immutable
sealed class CommentPostState {}

final class CommentPostInitial extends CommentPostState {}

final class CommentPostLoadingState extends CommentPostState {}

final class CommentPostSuccesfulState extends CommentPostState {
  final String commentId;

  CommentPostSuccesfulState({required this.commentId});
}

final class CommentPostNotFoundState extends CommentPostState {}

final class CommentPostServerErrorState extends CommentPostState {}
