part of 'fetch_suggession_user_bloc.dart';

@immutable
sealed class FetchSuggessionUserEvent {}

class SuggessionUserInitialFetchEvent extends FetchSuggessionUserEvent {}