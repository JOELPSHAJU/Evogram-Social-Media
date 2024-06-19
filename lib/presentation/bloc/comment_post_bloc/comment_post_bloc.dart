// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/repository/post_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'comment_post_event.dart';
part 'comment_post_state.dart';

class CommentPostBloc extends Bloc<CommentPostEvent, CommentPostState> {
  CommentPostBloc() : super(CommentPostInitial()) {
    on<CommentPostEvent>((event, emit) {});
    on<CommentPostButtonClickEvent>(commentPostButtonClickEvent);
  }

  FutureOr<void> commentPostButtonClickEvent(
      CommentPostButtonClickEvent event, Emitter<CommentPostState> emit) async {
    emit(CommentPostLoadingState());
    final Response result = await MainPostRepo.commentPost(
        postId: event.postId, userName: event.userName, content: event.content);
    final responseBody = jsonDecode(result.body);
    if (result.statusCode == 200) {
      emit(CommentPostSuccesfulState(commentId: responseBody['commentId']));
    } else if (responseBody['status'] == 404) {
      emit(CommentPostNotFoundState());
    } else if (responseBody['status'] == 500) {
      emit(CommentPostServerErrorState());
    }
  }
}
