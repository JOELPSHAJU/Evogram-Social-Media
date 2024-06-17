import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/application/core/sharedpreferences.dart';
import 'package:evogram/application/core/urls.dart';
import 'package:evogram/domain/models/conversation_model.dart';
import 'package:evogram/domain/models/get_user_model.dart';
import 'package:evogram/domain/repository/chat_repository.dart';
import 'package:evogram/domain/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
part 'fetch_all_conversations_event.dart';
part 'fetch_all_conversations_state.dart';

class FetchAllConversationsBloc
    extends Bloc<FetchAllConversationsEvent, FetchAllConversationsState> {
  // List<GetUserModel> users = [];
  // List<ConversationModel> conversation = [];

  FetchAllConversationsBloc() : super(FetchAllConversationsInitial()) {
    on<FetchAllConversationsEvent>((event, emit) {});
    on<AllConversationsInitialFetchEvent>(allConversationsInitialFetchEvent);
    // on<SearchConversationsEvent>(searchConversationsEvent);
  }

  FutureOr<void> allConversationsInitialFetchEvent(
      AllConversationsInitialFetchEvent event,
      Emitter<FetchAllConversationsState> emit) async {
    emit(FetchAllConversationsLoadingState());
    final userid = await getUserId();
    final Response response = await ChatRepo.getAllConversations();
    debugPrint('conversation fetch statuscode is-${response.statusCode}');
    debugPrint('fetchall conversations body is -${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> conversationsData = responseData['data'];

      final List<ConversationModel> conversations = conversationsData
          .map((conversationJson) =>
              ConversationModel.fromJson(conversationJson))
          .toList();
      final List<String> otherUserIds = conversations
          .expand((conversation) => conversation.members)
          .where((userId) => userId != userid)
          .toList();

      List<GetUserModel> otherUsers = [];

      for (String userId in otherUserIds) {
        final Response userResponse =
            await LoginUserRepo.getSingleUser(userid: userId);
        if (userResponse.statusCode == 200) {
          final Map<String, dynamic> userJson = jsonDecode(userResponse.body);
          final GetUserModel user = GetUserModel.fromJson(userJson);
          otherUsers.add(user);
        }
      }
      // users.addAll(otherUsers);

      if (otherUsers.length == otherUserIds.length) {
        emit(FetchAllConversationsSuccesfulState(
          conversations: conversations,
          otherUsers: otherUsers,
          // filteredUsers: otherUsers,
        ));
      } else {
        emit(FetchAllConversationsErrorState());
      }
    } else {
      emit(FetchAllConversationsErrorState());
    }
  }

  // FutureOr<void> searchConversationsEvent(SearchConversationsEvent event,
  //     Emitter<FetchAllConversationsState> emit) async {
  //   final filteredUsers = users
  //       .where((element) => element.userName.contains(event.query))
  //       .toList();
  //   emit(FetchAllConversationsSuccesfulState(
  //       conversations: conversation,
  //       otherUsers: users,
  //       filteredUsers: filteredUsers));
  // }
}
