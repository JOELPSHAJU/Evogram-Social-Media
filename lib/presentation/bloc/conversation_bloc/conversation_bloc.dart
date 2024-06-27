import 'dart:async';
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/getall_message_model.dart';
import 'package:evogram/domain/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  List<AllMessagesModel> messagesList = [];
  ConversationBloc() : super(ConversationInitial()) {
    on<ConversationEvent>((event, emit) {});
    on<CreateConversationButtonClickEvent>(createConversationButtonClickEvent);
    on<GetAllMessagesInitialFetchEvent>(getAllMessagesInitialFetchEvent);
    on<AddNewMessageEvent>(addNewMessageEvent);
  }

  FutureOr<void> createConversationButtonClickEvent(
      CreateConversationButtonClickEvent event,
      Emitter<ConversationState> emit) async {
    emit(ConversationLoadingState());
    final Response response =
        await ChatRepo.createConversation(members: event.members);
    debugPrint('create conversation statuscode-${response.statusCode}');
    debugPrint('create conversation response body-${response.body}');
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final String conversationId = responseData['data']['_id'];
    debugPrint('create conversation response-$responseData');
    if (response.statusCode == 200) {
      emit(ConversationSuccesfulState(conversationId: conversationId));
    } else {
      emit(ConversationErrorState());
    }
  }

  FutureOr<void> getAllMessagesInitialFetchEvent(
      GetAllMessagesInitialFetchEvent event,
      Emitter<ConversationState> emit) async {
    emit(GetAllMessagesLoadingState());
    final Response response =
        await ChatRepo.getAllMessages(conversationId: event.conversationId);
    debugPrint("get all messages statuscode-${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];
      messagesList =
          dataList.map((json) => AllMessagesModel.fromJson(json)).toList();
      messagesList.sort(
        (a, b) => a.createdAt.compareTo(b.createdAt),
      );
      emit(GetAllMessagesSuccesfulState(messagesList: messagesList));
    } else {
      emit(GetAllMessagesErrorState());
    }
  }

  FutureOr<void> addNewMessageEvent(
      AddNewMessageEvent event, Emitter<ConversationState> emit) async {
    messagesList.add(event.message);
    messagesList.sort(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );
    emit(GetAllMessagesSuccesfulState(messagesList: messagesList));
  }
}
