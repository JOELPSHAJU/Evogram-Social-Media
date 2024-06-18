part of 'fetch_saved_posts_bloc.dart';

@immutable
sealed class FetchSavedPostsState {}

final class FetchSavedPostsInitial extends FetchSavedPostsState {}

final class FetchSavedPostsLoadingState extends FetchSavedPostsState {}

final class FetchSavedPostsSuccesfulState extends FetchSavedPostsState {
  final List<SavedPostModel> posts;

  FetchSavedPostsSuccesfulState({required this.posts});
}

final class FetchSavedPostsServerErrorState extends FetchSavedPostsState {}

final class FetchSavedPostsErrorState extends FetchSavedPostsState {}
