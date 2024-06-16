part of 'follow_unfollow_user_bloc.dart';

@immutable
sealed class FollowUnfollowUserEvent {}

class FollowUserButtonClickEvent extends FollowUnfollowUserEvent {
  final String followeesId;

  FollowUserButtonClickEvent({required this.followeesId});
}

class UnFollowUserButtonClickEvent extends FollowUnfollowUserEvent {
  final String followeesId;

  UnFollowUserButtonClickEvent({required this.followeesId});
}
