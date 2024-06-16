part of 'fetch_followers_bloc.dart';

@immutable
sealed class FetchFollowersState {}

final class FetchFollowersInitial extends FetchFollowersState {}
final class FetchFollowersLoadingState extends FetchFollowersState {}

final class FetchFollowersSuccessState extends FetchFollowersState  {
  final FollowersModel followers;

  FetchFollowersSuccessState({required this.followers});
}

final class FetchFollowersInternalErrorState extends FetchFollowersState {}