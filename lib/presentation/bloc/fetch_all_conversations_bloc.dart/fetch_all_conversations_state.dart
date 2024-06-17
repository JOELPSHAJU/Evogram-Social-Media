part of 'fetch_all_conversations_bloc.dart';

@immutable
sealed class FetchAllConversationsState {}

final class FetchAllConversationsInitial extends FetchAllConversationsState {}

final class FetchAllConversationsLoadingState
    extends FetchAllConversationsState {}

final class FetchAllConversationsSuccesfulState
    extends FetchAllConversationsState {
  final List<ConversationModel> conversations;
  final List<GetUserModel> otherUsers;
  // final List<GetUserModel> filteredUsers;

  FetchAllConversationsSuccesfulState(
      {required this.conversations,
      required this.otherUsers,
      // required this.filteredUsers
      });
}

final class FetchAllConversationsErrorState
    extends FetchAllConversationsState {}
