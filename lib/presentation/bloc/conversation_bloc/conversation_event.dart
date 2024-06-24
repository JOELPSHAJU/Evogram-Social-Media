part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

class CreateConversationButtonClickEvent extends ConversationEvent {
  final List<String> members;

  CreateConversationButtonClickEvent({required this.members});
}

class GetAllMessagesInitialFetchEvent extends ConversationEvent {
  final String conversationId;

  GetAllMessagesInitialFetchEvent({required this.conversationId});
}

class AddNewMessageEvent extends ConversationEvent {
  final AllMessagesModel message;

  AddNewMessageEvent({required this.message});
}
