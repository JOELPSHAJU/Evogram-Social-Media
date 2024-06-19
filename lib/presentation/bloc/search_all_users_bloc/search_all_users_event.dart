part of 'search_all_users_bloc.dart';

@immutable
sealed class SearchAllUsersEvent {}

class SearchUserInitilEvent extends SearchAllUsersEvent {
  final String query;

  SearchUserInitilEvent({required this.query});
}
