part of 'fetch_suggession_user_bloc.dart';

@immutable
sealed class FetchSuggessionUserState {}

final class FetchSuggessionUserInitial extends FetchSuggessionUserState {}

final class FetchSuggessionSucessState extends FetchSuggessionUserState {
  final SuggessionUserModel suggessionUserModel;

  FetchSuggessionSucessState({required this.suggessionUserModel});
}

final class FetchSuggessionLoadingState extends FetchSuggessionUserState {}

final class FetchSuggessionUserErrorState extends FetchSuggessionUserState {
  final String error;

  FetchSuggessionUserErrorState({required this.error});

}

final class FetchSuggessionUserInternalErrorState extends FetchSuggessionUserState {
  final String error;

  FetchSuggessionUserInternalErrorState({required this.error});
}
