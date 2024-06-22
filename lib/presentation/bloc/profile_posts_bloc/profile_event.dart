part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileInitialPostFetchEvent extends ProfileEvent {
  final String userId;

  ProfileInitialPostFetchEvent({required this.userId});
}

// class ProfileInitialDetailsFetchEvent extends ProfileEvent {}
