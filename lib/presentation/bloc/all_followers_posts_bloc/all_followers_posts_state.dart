

part of 'all_followers_posts_bloc.dart';

@immutable
sealed class AllFollowersPostsState {
  final posts;

  const AllFollowersPostsState(this.posts);
}

final class AllFollowersPostsInitial extends AllFollowersPostsState {
  const AllFollowersPostsInitial(super.posts);
}

final class AllFollowersPostsLoadingState extends AllFollowersPostsState {
  const AllFollowersPostsLoadingState(super.posts);
}

final class AllFollowersPostsSuccesfulState extends AllFollowersPostsState {
  const AllFollowersPostsSuccesfulState({required posts}) : super(posts);
}

final class AllFollowersPostsServerErrorState extends AllFollowersPostsState {
  const AllFollowersPostsServerErrorState(super.posts);
}
