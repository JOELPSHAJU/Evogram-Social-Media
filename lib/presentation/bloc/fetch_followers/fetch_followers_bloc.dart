import 'dart:async';
import 'dart:convert';

import 'package:evogram/domain/models/followers_model.dart';
import 'package:evogram/domain/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
part 'fetch_followers_event.dart';
part 'fetch_followers_state.dart';

class FetchFollowersBloc
    extends Bloc<FetchFollowersEvent, FetchFollowersState> {
  FetchFollowersBloc() : super(FetchFollowersInitial()) {
    on<FetchFollowersEvent>((event, emit) {});
    on<FetchFollowersInitialEvent>(fetchfollowersevent);
  }

  FutureOr<void> fetchfollowersevent(FetchFollowersInitialEvent event, Emitter<FetchFollowersState> emit) async{
        emit(FetchFollowersLoadingState());
    final Response response = await LoginUserRepo.fetchfollowers();
    
    if (response.statusCode == 200) {
     
       final Map<String, dynamic> responsedata = jsonDecode(response.body);
      FollowersModel followers =
          FollowersModel.fromJson(responsedata);
    
   return  emit(FetchFollowersSuccessState(followers: followers));
    } else if (response.statusCode == 500) {
    return  emit(FetchFollowersInternalErrorState());
    }
  }
}
