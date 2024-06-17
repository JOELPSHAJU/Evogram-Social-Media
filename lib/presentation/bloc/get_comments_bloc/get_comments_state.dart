part of 'get_comments_bloc.dart';

@immutable
sealed class GetCommentsState {}

final class GetCommentsInitial extends GetCommentsState {}

final class GetCommentsLoadingState extends GetCommentsState {}

final class GetCommentsSuccsfulState extends GetCommentsState {
  final List<Comment> comments;

  GetCommentsSuccsfulState({required this.comments});
}

final class GetCommentsServerErrorState extends GetCommentsState {}
