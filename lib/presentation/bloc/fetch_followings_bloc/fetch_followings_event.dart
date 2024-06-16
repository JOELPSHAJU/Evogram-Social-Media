part of 'fetch_followings_bloc.dart';

@immutable
sealed class FetchFollowingsEvent {}

class FollowingsInitialFetchEvent extends FetchFollowingsEvent {}
