part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfilePostFetchLoadingState extends ProfileState {}

final class ProfilePostFetchSuccesfulState extends ProfileState {
  final List<Post> posts;

  ProfilePostFetchSuccesfulState({required this.posts});
}

final class ProfilePostFetchUserNotFoundState extends ProfileState {}

final class ProfilePostFetchErrorState extends ProfileState {}

final class ProfilePostFetchServerErrorState extends ProfileState {}

// final class ProfileDetailsFetchLoadingState extends ProfileState {}

// final class ProfileDetailsFetchSuccesfulState extends ProfileState {
//   final User user;

//   ProfileDetailsFetchSuccesfulState({required this.user});
// }

// final class ProfileDetailsFetchServerErrorState extends ProfileState {}

// final class ProfileDetailsFetchUserNotFoundState extends ProfileState {}
