part of 'add_message_bloc.dart';

@immutable
sealed class AddMessageState {}

final class AddMessageInitial extends AddMessageState {}

final class AddMessageLoadingState extends AddMessageState {}

final class AddMessageSuccesfulState extends AddMessageState {}

final class AddMessageErrorState extends AddMessageState {}
