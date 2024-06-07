part of 'addpost_bloc.dart';

@immutable
sealed class AddpostState {}

final class AddpostInitial extends AddpostState {}

final class AddPostSuccesState extends AddpostState {}

final class AddPostErrorState extends AddpostState {
  final String error;

  AddPostErrorState({required this.error});
}

final class AddPostLoadingstate extends AddpostState {}

final class SelectImageToPostSuccessState extends AddpostState {}

final class SelectImageToPostError extends AddpostState {}

final class SelectImageToPostLoadingstate extends AddpostState {}
