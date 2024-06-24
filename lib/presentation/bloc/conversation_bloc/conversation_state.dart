part of 'conversation_bloc.dart';

@immutable
sealed class ConversationState {}

final class ConversationInitial extends ConversationState {}

final class ConversationLoadingState extends ConversationState {}

final class ConversationSuccesfulState extends ConversationState {
  final String conversationId;

  ConversationSuccesfulState({required this.conversationId});
}

final class ConversationErrorState extends ConversationState {}

//fetch all messages initil event state
final class GetAllMessagesLoadingState extends ConversationState {}

final class GetAllMessagesSuccesfulState extends ConversationState {
  final List<AllMessagesModel> messagesList;

  GetAllMessagesSuccesfulState({required this.messagesList});
}

final class GetAllMessagesErrorState extends ConversationState {}
