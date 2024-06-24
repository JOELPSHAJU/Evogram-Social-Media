part of 'add_message_bloc.dart';

@immutable
sealed class AddMessageEvent {}

class AddMessageButtonClickEvent extends AddMessageEvent {
  final String message;
  final String senderId;
  final String recieverId;
  final String conversationId;

  AddMessageButtonClickEvent(
      {required this.message,
      required this.senderId,
      required this.recieverId,
      required this.conversationId});
}

class SearchEvent extends AddMessageEvent {}
