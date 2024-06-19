part of 'fetch_explore_post_bloc.dart';

@immutable
sealed class FetchExplorePostState {}

final class FetchExplorePostInitial extends FetchExplorePostState {}

final class FetchExplorePostLoadingState extends FetchExplorePostState {}

final class FetchExplorePostSuccesfulState extends FetchExplorePostState {
  final List<ExplorePostModel> posts;

  FetchExplorePostSuccesfulState({required this.posts});
}

final class FetchExplorePostServerErrorState extends FetchExplorePostState {}

final class FetchExplorePostErrorState extends FetchExplorePostState {}

