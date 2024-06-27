import 'dart:async';
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/searchusermodel.dart';
import 'package:evogram/domain/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';



part 'search_all_users_event.dart';
part 'search_all_users_state.dart';

class SearchAllUsersBloc
    extends Bloc<SearchAllUsersEvent, SearchAllUsersState> {
  SearchAllUsersBloc() : super(SearchAllUsersInitial()) {
    on<SearchAllUsersEvent>((event, emit) {});
    on<SearchUserInitilEvent>(searchUserInitilEvent);
  }

  FutureOr<void> searchUserInitilEvent(
      SearchUserInitilEvent event, Emitter<SearchAllUsersState> emit) async {
    emit(SearchAllUsersLoadingState());
    final Response response =
        await LoginUserRepo.searchAllUsers(query: event.query);
    if (response.statusCode == 200) {
      debugPrint('searchallusers statuscode-${response.statusCode}');

      List<dynamic> jsonResponse = jsonDecode(response.body);
      final List<UserIdSearchModel> users =
          jsonResponse.map((user) => UserIdSearchModel.fromJson(user)).toList();
      emit(SearchAllUsersSuccesfulState(users: users));
    } else {
      emit(SearchAllUsersErrorState());
    }
  }
}
