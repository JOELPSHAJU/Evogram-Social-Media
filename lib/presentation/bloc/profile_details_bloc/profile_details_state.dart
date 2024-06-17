part of 'profile_details_bloc.dart';

@immutable
sealed class ProfileDetailsState {}

final class ProfileDetailsInitial extends ProfileDetailsState {}

final class ProfileDetailsFetchLoadingState extends ProfileDetailsState {}

final class ProfileDetailsFetchSuccesfulState extends ProfileDetailsState {
  final User user;

  ProfileDetailsFetchSuccesfulState({required this.user});
}

final class ProfileDetailsFetchServerErrorState extends ProfileDetailsState {}

final class ProfileDetailsFetchUserNotFoundState extends ProfileDetailsState {}
