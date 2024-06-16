part of 'follow_unfollow_user_bloc.dart';

@immutable
sealed class FollowUnfollowUserState {}

final class FollowUnfollowUserInitial extends FollowUnfollowUserState {}

final class FollowUserLoadingState extends FollowUnfollowUserState {}

final class FollowUserSuccesfulState extends FollowUnfollowUserState {}

final class FollowUserErrorState extends FollowUnfollowUserState {}

final class UnFollowUserErrorState extends FollowUnfollowUserState {}

final class UnFollowUserSuccesfulState extends FollowUnfollowUserState {}

final class UnFollowUserLoadingState extends FollowUnfollowUserState {}