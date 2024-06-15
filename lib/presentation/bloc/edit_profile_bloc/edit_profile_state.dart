part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoadingState extends EditProfileState {}

final class EditProfileSuccessState extends EditProfileState {}

final class EditProfileInternalErrorState extends EditProfileState {}

final class EditProfileErrorState extends EditProfileState {
 final String error;

  EditProfileErrorState({required this.error});
}
