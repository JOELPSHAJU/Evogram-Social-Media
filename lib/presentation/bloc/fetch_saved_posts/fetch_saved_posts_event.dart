part of 'fetch_saved_posts_bloc.dart';

@immutable
sealed class FetchSavedPostsEvent {}

class SavedPostsInitialFetchEvent extends FetchSavedPostsEvent {}
