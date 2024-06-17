part of 'fetch_all_conversations_bloc.dart';

@immutable
sealed class FetchAllConversationsEvent {}

class AllConversationsInitialFetchEvent extends FetchAllConversationsEvent {}

class SearchConversationsEvent extends FetchAllConversationsEvent {
  final String query;

  SearchConversationsEvent({required this.query});
}
