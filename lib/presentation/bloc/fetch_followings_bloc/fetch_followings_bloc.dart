import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/followings_model.dart';
import 'package:evogram/domain/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

part 'fetch_followings_event.dart';
part 'fetch_followings_state.dart';

class FetchFollowingsBloc
    extends Bloc<FetchFollowingsEvent, FetchFollowingsState> {
  FetchFollowingsBloc() : super(FetchFollowingsInitial()) {
    on<FetchFollowingsEvent>((event, emit) {});
    on<FollowingsInitialFetchEvent>(followingsInitialFetchEvent);
  }

  FutureOr<void> followingsInitialFetchEvent(FollowingsInitialFetchEvent event,
      Emitter<FetchFollowingsState> emit) async {
    emit(FetchFollowingsLoadingState());
    final Response result = await LoginUserRepo.fetchfollowing();
    final responseBody = jsonDecode(result.body);
    debugPrint('followers fetch status code-${result.statusCode}');
    if (result.statusCode == 200) {
      final FollowingModel followingsModel =
          FollowingModel.fromJson(responseBody);
      return emit(
          FetchFollowingsSuccesfulState(followingsModel: followingsModel));
    } else {
      return emit(FetchFollowingsErrorState());
    }
  }
}
