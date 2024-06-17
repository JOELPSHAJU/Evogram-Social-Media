part of 'profile_details_bloc.dart';

@immutable
sealed class ProfileDetailsEvent {}

class ProfileInitialDetailsFetchEvent extends ProfileDetailsEvent {}
