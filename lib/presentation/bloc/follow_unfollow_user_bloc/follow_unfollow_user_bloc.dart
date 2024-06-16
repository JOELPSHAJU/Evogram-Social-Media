import 'package:bloc/bloc.dart';
import 'package:evogram/domain/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'follow_unfollow_user_event.dart';
part 'follow_unfollow_user_state.dart';

class FollowUnfollowUserBloc
    extends Bloc<FollowUnfollowUserEvent, FollowUnfollowUserState> {
  FollowUnfollowUserBloc() : super(FollowUnfollowUserInitial()) {
    on<FollowUnfollowUserEvent>((event, emit) {});
    on<FollowUserButtonClickEvent>(followUserButtonClickEvent);
    on<UnFollowUserButtonClickEvent>(unfollowUserButtonClickEvent);
  }
  Future<void> followUserButtonClickEvent(FollowUserButtonClickEvent event,
      Emitter<FollowUnfollowUserState> emit) async {
    emit(FollowUserLoadingState());
    final Response result =
        await LoginUserRepo.followUser(followeesId: event.followeesId);
    debugPrint('follow statuscode-${result.statusCode}');
    if (result.statusCode == 200) {
     return emit(FollowUserSuccesfulState());
    } else {
     return emit(FollowUserErrorState());
    }
  }

  Future<void> unfollowUserButtonClickEvent(UnFollowUserButtonClickEvent event,
      Emitter<FollowUnfollowUserState> emit) async {
    emit(UnFollowUserLoadingState());
    final Response result =
        await LoginUserRepo.unfollowUser(followeesId: event.followeesId);
    debugPrint('unfollow statuscode-${result.statusCode}');
    if (result.statusCode == 200) {
    return  emit(UnFollowUserSuccesfulState());
    } else {
     return emit(FollowUserErrorState());
    }
  }
}
