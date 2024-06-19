// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/repository/post_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';


part 'like_post_event.dart';
part 'like_post_state.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  LikePostBloc() : super(LikePostInitial()) {
    on<LikePostEvent>((event, emit) {});
    on<LikePostButtonClickEvent>(likePostButtonClickEvent);
    on<UnlikePostButtonClickEvent>(unlikePostButtonClickEvent);
  }

  FutureOr<void> likePostButtonClickEvent(
      LikePostButtonClickEvent event, Emitter<LikePostState> emit) async {
    emit(LikePostLoadingState());
    final Response result = await MainPostRepo.likePost(postId: event.postId);
    final responseBody = jsonDecode(result.body);
    debugPrint(result.statusCode.toString());
    debugPrint(result.body);
    if (result.statusCode == 200) {
      emit(LikePostSuccesfulState());
    } else if (responseBody['status'] == 404) {
      emit(LikePostNotFoundState());
    } else if (responseBody['message'] == 'User already liked the post') {
      emit(LikePostAlreadyLikedState());
    } else if (responseBody['status'] == 500) {
      emit(LikePostServerErrorState());
    }
  }

  FutureOr<void> unlikePostButtonClickEvent(
      UnlikePostButtonClickEvent event, Emitter<LikePostState> emit) async {
    emit(UnlikePostLoadingState());
    final Response result = await MainPostRepo.unlikePost(postId: event.postId);
    final responseBody = jsonDecode(result.body);
    debugPrint(result.statusCode.toString());
    debugPrint(result.body);
    if (result.statusCode == 200) {
      emit(UnlikePostSuccesfulState());
    } else if (responseBody['status'] == 404) {
      emit(UnlikePostNotFoundState());
    } else if (responseBody['message'] == 'User has not liked the post') {
      emit(UnlikePostUserNotLikedPostState());
    } else if (responseBody['status'] == 500) {
      emit(UnlikePostServerErrorState());
    }
  }
}
