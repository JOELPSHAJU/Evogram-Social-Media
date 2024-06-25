
part of 'all_followers_posts_bloc.dart';

@immutable
sealed class AllFollowersPostsEvent {}

class AllFollowersPostsInitialFetchEvent extends AllFollowersPostsEvent {
   final int n;

  AllFollowersPostsInitialFetchEvent({required this.n});
}

class LoadMoreEvent extends AllFollowersPostsEvent {}
final class LoadMoreFollowersPostsEvent extends AllFollowersPostsEvent {}